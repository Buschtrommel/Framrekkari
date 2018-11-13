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

ListItem {
    id: projectsListItem

    contentHeight: column.height + Theme.paddingMedium
    width: parent.width

    ListView.onAdd: AddAnimation { target: projectsListItem }
    ListView.onRemove: RemoveAnimation { target: projectsListItem }

    onClicked: {
        pageStack.push(Qt.resolvedUrl("../pages/ProjectPage.qml"), {projectName: model.name, projectSlug: model.slug})
    }


    Column {
        id: column
        anchors { left: parent.left; leftMargin: Theme.horizontalPageMargin; right: parent.right; rightMargin: Theme.horizontalPageMargin }

        Label {
            id: nameLabel
            text: model.name
            width: parent.width
            color: projectsListItem.highlighted ? Theme.highlightColor : Theme.primaryColor
            maximumLineCount: 1
            truncationMode: TruncationMode.Fade
            elide: Text.ElideRight
            textFormat: Text.PlainText
        }

        Row {
            width: parent.width
            spacing : Theme.paddingSmall

            Text {
                id: sourceLang
                text: qsTr("Source lang: %1").arg(langHelper.getLanguageName(model.sourceLanguageCode))
                font.pixelSize: Theme.fontSizeExtraSmall
                color: projectsListItem.highlighted ? Theme.highlightColor : Theme.primaryColor
                width: Math.min(parent.width - parent.spacing - projectSlug.width, implicitWidth)
                elide: Text.ElideRight
            }

            Text {
                id: projectSlug
                text: qsTr("Slug: %1").arg(model.slug)
                font.pixelSize: Theme.fontSizeExtraSmall
                color: projectsListItem.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
        }

        Text {
            id: description
            text: model.description
            font.pixelSize: Theme.fontSizeTiny
            color: projectsListItem.highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }
    }
}
