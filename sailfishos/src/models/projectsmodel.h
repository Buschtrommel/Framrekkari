/*
    Framrekkari - Transifex Client for SailfishOS
    Copyright (C) 2014-2018  Hüssenbergnetz/Matthias Fehring
    https://github.com/Buschtrommel/Framrekkari

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/

#ifndef PROJECTSMODEL_H
#define PROJECTSMODEL_H

#include <QAbstractListModel>
#include <QVariantMap>
#include "../api/projectsapi.h"

class ProjectObject;

class ProjectsModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit ProjectsModel(QObject *parent = 0);

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
//    int columnCount(const QModelIndex& = QModelIndex()) const;
    QHash<int, QByteArray> roleNames() const;
    QModelIndex index(int row, int column = 0, const QModelIndex &parent = QModelIndex()) const;

signals:
    void gotData(int projectCount);
    void gotError(const QString &projectsModelErrorString);

public slots:
    void refresh(int accountIdx, int start = 0, int end = 0);
    void clear();

private slots:
    void populate(const QVariantList &data);
    void errorHandler(const QString &errorString);

private:
    QList<ProjectObject*> m_projects;
    static const int SlugRole;
    static const int NameRole;
    static const int DescriptionRole;
    static const int SourceLanguageCodedRole;

    ProjectsAPI pAPI;
};

#endif // PROJECTSMODEL_H
