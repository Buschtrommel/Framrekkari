/*
    Framrekkari - Transifex Client for SailfishOS
    Copyright (C) 2014  Buschtrommel/Matthias Fehring
    Contact: Matthias Fehring <kontakt@buschmann23.de>

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

import QtQuick 2.0
import Sailfish.Silica 1.0

ListItem {
    id: projectResourceItem

    property double overall: model.translated + model.untranslated

    contentHeight: column.height + Theme.paddingMedium
    width: parent.width

//    menu: accountMenu

    ListView.onAdd: AddAnimation { target: projectResourceItem }
    ListView.onRemove: RemoveAnimation { target: projectResourceItem }

//    Image {
//        width: parent.width; height: Math.min(sourceSize.height, parent.contentHeight)
//        anchors { bottom: parent.bottom }
//        sourceSize.width: 480; sourceSize.height: 260
//        source: "image://theme/graphic-gradient-home-bottom"
//        source: "image://theme/graphic-gradient-edge"
//    }


    Column {
        id: column
        width: parent.width

        Row {
            anchors { left: parent.left; leftMargin: Theme.paddingLarge; right: parent.right; rightMargin: Theme.paddingLarge }
            height: nameLabel.height
            spacing: 5

            Label {
                id: nameLabel
                text: model.slug
                color: projectResourceItem.highlighted ? Theme.highlightColor : Theme.primaryColor
                maximumLineCount: 1
                truncationMode: TruncationMode.Fade
                elide: Text.ElideRight
                textFormat: Text.PlainText
            }

            Text {
                id: untranslated
                width: parent.width - nameLabel.width - parent.spacing
                text: qsTr("%n string(s) to translate", "", model.untranslated)
                font.pixelSize: Theme.fontSizeExtraSmall
                color: projectResourceItem.highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                maximumLineCount: 1
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignRight
                anchors.baseline: nameLabel.baseline
            }
        }

        Row {
            anchors { left: parent.left; leftMargin: Theme.paddingLarge; right: parent.right; rightMargin: Theme.paddingLarge }

            Row {
                width: parent.width/2
                spacing: 5
                height: finished.height

                Image {
                    id: finishedIcon
                    source: "image://theme/icon-s-edit"
                    width: finished.font.pixelSize; height: width;
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    id: finished
                    text: Number(Number((model.translated/overall)*100).toFixed(1)).toLocaleString(Qt.locale()) + "%"
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: projectResourceItem.highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                }
            }

            Row {
                width: parent.width/2
                spacing: 5
                height: reviewed.height

                Image {
                    id: reviewedIcon
                    source: "/usr/share/harbour-framrekkari/icons/icon-s-watch.png"
                    width: reviewed.font.pixelSize; height: width;
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    id: reviewed
                    text: Number(Number((model.reviewed/overall)*100).toFixed(1)).toLocaleString(Qt.locale()) + "%"
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: projectResourceItem.highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                }
            }
        }

        Row {
            anchors { left: parent.left; leftMargin: Theme.paddingLarge; right: parent.right; rightMargin: Theme.paddingLarge }

            Row {
                width: parent.width/2
                spacing: 5
                height: lastUpdate.height

                Image {
                    id: timerIcon
                    source: "image://theme/icon-s-date"
                    width: lastUpdate.font.pixelSize; height: width;
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    id: lastUpdate
                    text: Qt.formatDateTime(model.lastUpdate, qsTr("dd.MM.yy hh:mmAP"))
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: projectResourceItem.highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                }
            }

            Row {
                width: parent.width/2
                spacing: 5
                height: commiter.height

                Image {
                    id: commiterIcon
                    source: "image://theme/icon-m-person"
                    width: commiter.font.pixelSize; height: width;
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    id: commiter
                    text: model.lastCommiter
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: projectResourceItem.highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                }
            }
        }

        ProgressBar {
            width: parent.width
            height: Theme.itemSizeExtraSmall
            minimumValue: 0
            maximumValue: overall
            value: model.translated
        }
    }
}
