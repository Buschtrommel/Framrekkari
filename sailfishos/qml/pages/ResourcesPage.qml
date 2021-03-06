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

import QtQuick 2.2
import Sailfish.Silica 1.0

import "../delegates"


Page {
    id: resourcesPages
    objectName: "ResourceView"

    property string accountName: framrekkari.accountName
    property int accountIndex: framrekkari.accountIndex

    property string projectName
    property string projectSlug
    property string projectSrcLang
    property string lang
    property string langName
    property var resources: []

    property int projectLangIndex

    Component.onCompleted: { framrekkari.currentLangName = resourcesPages.langName; projectResourceModel.refresh(projectSlug, lang, resources, accountIndex) }
    Component.onDestruction: { framrekkari.currentLangName = ""; projectResourceModel.clear() }

    Connections {
        target: projectResourceModel
        onGotError: { errorDisplay.text = qsTr("Ooops, the following error occured:") + " " + projectResourcesModelErrorString; errorDisplay.enabled = true }
    }

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: visible
        visible: resourcesListView.count === 0;
        size: BusyIndicatorSize.Large
    }

    SilicaListView {
        id: resourcesListView
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("Refresh")
                onClicked: {
                    errorDisplay.enabled = false
                    projectResourceModel.refresh(resourcesPages.projectSlug, resourcesPages.lang, resourcesPages.resources, resourcesPages.accountIndex)
                }
            }
        }

        VerticalScrollDecorator {}

        header: PageHeader { title:qsTr("Resources:") + " " + langName }

        model: projectResourceModel
        delegate: ResourcesDelegate {
            onClicked: {
                coverConnector.resourceTranslated = model.translated
                coverConnector.resourceUntranslated = model.untranslated
                coverConnector.resourceReviewed = model.reviewed
                pageStack.push(Qt.resolvedUrl("TranslationStringsPage.qml"), {projectName: projectName, projectSlug: projectSlug, lang: lang, resource: model.slug, langName: langName, projectSrcLang: projectSrcLang, projectLangIndex: resourcesPages.projectLangIndex, projectResourceIndex: model.index})
            }
        }

        ViewPlaceholder {
            id: errorDisplay
            enabled: false
        }
    }
}


