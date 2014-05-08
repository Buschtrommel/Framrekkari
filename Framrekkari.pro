TEMPLATE = app

TARGET = harbour-framrekkari

CONFIG += sailfishapp
#CONFIG += link_pkgconfig

QT += core
QT += network
QT += sql

#PKGCONFIG += mlite5

translations.path = /usr/share/harbour-framrekkari/translations
translations.files = l10n/*.qm
INSTALLS += translations

icons.path = /usr/share/harbour-framrekkari/icons
icons.files = icons/*.png
INSTALLS += icons

SOURCES += \
    src/main.cpp \
    src/configuration.cpp \
    src/models/accountsmodel.cpp \
    src/network.cpp \
    src/api/projectsapi.cpp \
    src/api/apihelper.cpp \
    src/models/projectsmodel.cpp \
    src/dbmanager.cpp \
    src/models/favoredprojectsmodel.cpp \
    src/api/statisticsapi.cpp \
    src/models/projectlangstatsmodel.cpp \
    src/models/projectresourcesmodel.cpp \
    src/api/translationstringsapi.cpp \
    src/models/projecttranslationsmodel.cpp \
    src/md5generator.cpp \
    src/languagenamehelper.cpp

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    rpm/Framrekkari.spec \
    harbour-framrekkari.desktop \
    rpm/harbour-framrekkari.changes \
    rpm/harbour-framrekkari.yaml \
    qml/harbour-framrekkari.qml \
    qml/pages/About.qml \
    qml/pages/MainPage.qml \
    qml/pages/Settings.qml \
    qml/pages/Changelog.qml \
    qml/pages/parts/CLItem.qml \
    qml/dialogs/AccountDialog.qml \
    qml/delegates/AccountsDelegate.qml \
    qml/pages/AccountPage.qml \
    qml/pages/ProjectsListPage.qml \
    qml/delegates/ProjectsDelegate.qml \
    qml/common/FancyScroller.qml \
    qml/pages/ProjectPage.qml \
    qml/delegates/ProjectLangDelegate.qml \
    qml/pages/ResourcesPage.qml \
    qml/delegates/ResourcesDelegate.qml \
    qml/pages/TranslationStringsPage.qml \
    qml/delegates/TranslationsDelegate.qml \
    qml/pages/StringPage.qml \
    qml/delegates/PluralDelegate.qml \
    qml/js/helper.js \
    qml/common/OpenSlugField.qml \
    qml/common/MessageContainer.qml

HEADERS += \
    src/globals.h \
    src/configuration.h \
    src/models/accountsmodel.h \
    src/models/accountobject.h \
    src/network.h \
    src/api/projectsapi.h \
    src/api/apihelper.h \
    src/models/projectsmodel.h \
    src/models/projectobject.h \
    src/dbmanager.h \
    src/models/favoredprojectsmodel.h \
    src/models/favoredprojectobject.h \
    src/api/statisticsapi.h \
    src/models/langstatobject.h \
    src/models/projectlangstatsmodel.h \
    src/models/projectresourceobject.h \
    src/models/projectresourcesmodel.h \
    src/api/translationstringsapi.h \
    src/models/projecttranslationsmodel.h \
    src/models/translationsobject.h \
    src/md5generator.h \
    src/languagenamehelper.h

RESOURCES +=



