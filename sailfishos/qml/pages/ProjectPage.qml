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
    id: projectPage
    objectName: "ProjectView"

    property string accountName: framrekkari.accountName
    property int accountIndex: framrekkari.accountIndex
    property int accountType: framrekkari.accountType

    property string projectName
    property string projectSlug
    property string projectWebsite
    property string projectBugtracker
    property string projectTransInstractions
    property string projectDescription
    property string projectSrcLang
    property var projectResources: []

    property bool favored: favoredProjectsModel.isFavored(projectSlug, accountIndex)

    property bool inOperation: true

    Component.onCompleted: {framrekkari.currentProjectName = projectPage.projectName; projectsAPI.getProject(accountIndex, projectSlug, true) }
    Component.onDestruction: {framrekkari.currentProjectName = ""; projectLangstatsModel.clear() }


    Connections {
        target: projectsAPI
        onGotProjectError: {
            errorDisplay.text = qsTr("Ooops, the following error occured:") + " " + gotProjectErrorString
            errorDisplay.enabled = true
            inOperation = false
        }
        onGotProject: {
            projectWebsite = project["homepage"]
            projectBugtracker = project["bug_tracker"] ? project["bug_tracker"] : ""
            projectDescription = project["description"]
            description.text = project["long_description"] !== "" ? project["long_description"] : projectDescription
            owner.text = project["username"] ? project["username"] : ""
            tags.text = project["tags"]
            projectTransInstractions = project["trans_instructions"]
            projectSrcLang = project["source_language_code"]
            coverConnector.projectLangs = project["teams"].length

            var maintainersArray = project["maintainers"]
            var maintainersLength = maintainersArray.length
            var newMaintainersArray = []
            for (var i = 0; i < maintainersLength; i++)
                newMaintainersArray.push(maintainersArray[i]["username"]);

            projectResources.length = 0
            var resourcesArray = project["resources"]
            var resourcesArrayLength = resourcesArray.length
            for (var j = 0; j < resourcesArrayLength; j++)
                projectResources.push(resourcesArray[j]["slug"]);

            maintainers.text = newMaintainersArray.join(", ")

            if (projectResources.length > 0) {
                projectLangstatsModel.refresh(projectSlug, projectResources, accountIndex)
            } else {
                noResources.visible = true
            }

            inOperation = false
        }
    }


    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: visible
        visible: inOperation
        size: BusyIndicatorSize.Large
    }

    Column {
        id: columnHeader
        visible: !inOperation && !errorDisplay.enabled

        move: Transition { NumberAnimation { properties: "y"; easing.type: Easing.InOutQuad } }
        add: Transition { FadeAnimation {} }

        width: projectPage.width
        spacing: Theme.paddingLarge
        PageHeader { title: projectName }

        Text {
            id: description
            anchors { left: parent.left; leftMargin: Theme.horizontalPageMargin; right: parent.right; rightMargin: Theme.horizontalPageMargin }
            font.pixelSize: Theme.fontSizeSmall
            color: Theme.primaryColor
            wrapMode: Text.WordWrap
        }

        Row {
            anchors { left: parent.left; leftMargin: Theme.horizontalPageMargin; right: parent.right; rightMargin: Theme.horizontalPageMargin }
            height: tags.height
            visible: tags.text !== ""
            spacing: Theme.paddingSmall

            Image {
                id: tagIcon
                source: "image://fram/icon-s-tag?" + Theme.secondaryColor
                anchors { top: parent.top }
                width: tags.font.pixelSize; height: width
            }

            Text {
                id: tags
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.secondaryColor
                wrapMode: Text.WordWrap
                width: parent.width - tagIcon.width - parent.spacing
            }
        }

        Row {
            anchors { left: parent.left; leftMargin: Theme.horizontalPageMargin; right: parent.right; rightMargin: Theme.horizontalPageMargin }
            height: owner.height
            visible: owner.text !== ""
            spacing: Theme.paddingSmall

            Image {
                id: ownerIcon
                source: "image://theme/icon-s-task?" + Theme.secondaryColor
                anchors { top: parent.top }
                width: tags.font.pixelSize; height: width
            }

            Text {
                id: owner
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.secondaryColor
                wrapMode: Text.WordWrap
                width: parent.width - ownerIcon.width - parent.spacing
            }
        }

        Row {
            anchors { left: parent.left; leftMargin: Theme.horizontalPageMargin; right: parent.right; rightMargin: Theme.horizontalPageMargin }
            height: maintainers.height
            visible: maintainers.text !== ""
            spacing: Theme.paddingSmall

            Image {
                id: maintainerIcon
                source: "image://fram/icon-s-owner?" + Theme.secondaryColor
                anchors { top: parent.top }
                width: tags.font.pixelSize; height: width
                smooth: true
            }

            Text {
                id: maintainers
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.secondaryColor
                wrapMode: Text.WordWrap
                width: parent.width - maintainerIcon.width - parent.spacing
            }
        }

        SectionHeader { text: qsTr("Languages")/*; visible: languageList.count !== 0*/ }

        BusyIndicator {
            anchors.horizontalCenter: parent.horizontalCenter
            running: visible
            visible: languageList.count === 0 && !errorDisplay.enabled && !noResources.visible
            size: BusyIndicatorSize.Large
        }

        Text {
            id: noResources
            anchors { left: parent.left; leftMargin: Theme.horizontalPageMargin; right: parent.right; rightMargin: Theme.horizontalPageMargin }
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.secondaryColor
            wrapMode: Text.WordWrap
            visible: false
            text: qsTr("This project has so far created ​​no resources.")
        }
    }



    SilicaListView {
        id: languageList
        anchors.fill: parent
        spacing: 10

        VerticalScrollDecorator {}

        PullDownMenu {
            MenuItem {
                text: qsTr("Bugtracker")
                enabled: projectBugtracker !== ""
                onClicked: Qt.openUrlExternally(projectBugtracker)
            }
            MenuItem {
                text: qsTr("Translation instructions")
                enabled: projectTransInstractions !== ""
                onClicked: Qt.openUrlExternally(projectTransInstractions)
            }
            MenuItem {
                text: qsTr("Project website")
                enabled: projectWebsite !== ""
                onClicked: Qt.openUrlExternally(projectWebsite)
            }
            MenuItem {
                text: favored ? qsTr("Remove from favorites") : qsTr("Add to favorites")
                enabled: !inOperation && !errorDisplay.enabled
                onClicked: {
                    if (favored) {
                        favoredProjectsModel.remove(projectSlug, accountIndex)
                    } else {
                        favoredProjectsModel.append(projectName, projectSlug, projectDescription, projectSrcLang, accountIndex)
                    }
                    favored = !favored
                }
            }
            MenuItem {
                text: qsTr("Refresh")
                enabled: !inOperation
                onClicked: {
                    inOperation = true
                    errorDisplay.enabled = false
                    noResources.visible = false
//                    projectLangstatsModel.refresh(projectSlug, projectResources, accountIndex)
                    projectsAPI.getProject(accountIndex, projectSlug, true)
                }
            }
        }

        header: Item {
            id: header
            width: columnHeader.width
            height: columnHeader.height
            Component.onCompleted: columnHeader.parent = header
        }

        model: projectLangstatsModel
        delegate: ProjectLangDelegate {
            onClicked: {
                coverConnector.langTranslated = model.translated
                coverConnector.langUntranslated = model.untranslated
                coverConnector.langReviewed = model.reviewed
                pageStack.push(Qt.resolvedUrl("ResourcesPage.qml"), {projectName: projectName, projectSlug: projectSlug, lang: model.lang, resources: projectResources, langName: langHelper.getLanguageName(model.lang), projectSrcLang: projectSrcLang, projectLangIndex: model.index})
            }
            srcLang: projectSrcLang
        }

        ViewPlaceholder {
            id: errorDisplay
            enabled: false
        }
    }
}


