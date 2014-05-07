#include "projecttranslationsmodel.h"
#include "translationsobject.h"

const int ProjectTranslationsModel::KeyRole = Qt::UserRole + 1;
const int ProjectTranslationsModel::ContextRole = Qt::UserRole + 2;
const int ProjectTranslationsModel::CommentRole = Qt::UserRole + 3;
const int ProjectTranslationsModel::SourceRole = Qt::UserRole + 4;
const int ProjectTranslationsModel::TranslationRole = Qt::UserRole + 5;
const int ProjectTranslationsModel::ReviewedRole = Qt::UserRole + 6;
const int ProjectTranslationsModel::PluralizedRole = Qt::UserRole + 7;

ProjectTranslationsModel::ProjectTranslationsModel(QObject *parent) :
    QAbstractTableModel(parent)
{
    connect(&tAPI, SIGNAL(gotStrings(QVariantList)), this, SLOT(populate(QVariantList)));
    connect(&tAPI, SIGNAL(gotStringsError(QString)), this, SLOT(errorHandler(QString)));
}


QHash<int, QByteArray> ProjectTranslationsModel::roleNames() const {
    QHash<int, QByteArray> roles = QAbstractItemModel::roleNames();
    roles.insert(KeyRole, QByteArray("key"));
    roles.insert(ContextRole, QByteArray("context"));
    roles.insert(CommentRole, QByteArray("comment"));
    roles.insert(SourceRole, QByteArray("source"));
    roles.insert(TranslationRole, QByteArray("translation"));
    roles.insert(ReviewedRole, QByteArray("reviewed"));
    roles.insert(PluralizedRole, QByteArray("pluralized"));
    return roles;
}


int ProjectTranslationsModel::rowCount(const QModelIndex &) const
{
    return m_translations.size();
}

int ProjectTranslationsModel::columnCount(const QModelIndex&) const
{
    return 7;
}



QVariant ProjectTranslationsModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant(); // Return Null variant if index is invalid

    if (index.row() > (m_translations.size()-1) )
        return QVariant();

    TranslationsObject *tobj = m_translations.at(index.row());
    switch (role) {
    case Qt::DisplayRole: // The default display role now displays the first name as well
    case KeyRole:
        return QVariant::fromValue(tobj->key);
    case ContextRole:
        return QVariant::fromValue(tobj->context);
    case CommentRole:
        return QVariant::fromValue(tobj->comment);
    case SourceRole:
        return QVariant::fromValue(tobj->source);
    case TranslationRole:
        return QVariant::fromValue(tobj->translation);
    case ReviewedRole:
        return QVariant::fromValue(tobj->reviewed);
    case PluralizedRole:
        return QVariant::fromValue(tobj->pluralized);
    default:
        return QVariant();
    }
}



void ProjectTranslationsModel::refresh(const QString &project, const QString &resource, const QString &lang, int accountIdx)
{
    clear();

    tAPI.getStrings(project, resource, lang, accountIdx);
}



QModelIndex ProjectTranslationsModel::index(int row, int column, const QModelIndex &parent) const
{
    if (!hasIndex(row, column, parent))
             return QModelIndex();

    return createIndex(row, column);
}


void ProjectTranslationsModel::populate(const QVariantList &data)
{
    int length = data.length();

    beginInsertRows(QModelIndex(), 0, length-1);

    for (int i = 0; i < data.length(); ++i)
    {
        QVariantMap map = data.at(i).toMap();

        QVariantList context;
        if(map["context"].type() == QVariant::List) {
            context = map["context"].toList();
        } else {
            context << map["context"].toString();
        }

        QVariantMap sources;
        QVariantMap translations;
        bool pluralized = map["pluralized"].toBool();
        if (pluralized)
        {
            sources = map["source_string"].toMap();
            translations = map["translation"].toMap();
        } else {
            sources["1"] = map["source_string"].toString();
            translations["1"] = map["translation"].toString();
        }

        TranslationsObject *tobj = new TranslationsObject(map["key"].toString(), context, map["comment"].toString(), sources, translations, map["reviewed"].toBool(), pluralized);
        m_translations.append(tobj);
    }

    endInsertRows();
}


void ProjectTranslationsModel::clear()
{
    beginRemoveRows(QModelIndex(), 0, rowCount()-1);

    m_translations.clear();

    endRemoveRows();
}


void ProjectTranslationsModel::errorHandler(const QString &errorString)
{
    emit gotError(errorString);
}
