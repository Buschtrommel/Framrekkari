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
import "../common"

Page {
    id: projectsListPage

    property string accountName: framrekkari.accountName
    property int accountIndex: framrekkari.accountIndex

    property int startVal: 1
    property int endVal: 501
    property int count

    onStartValChanged: console.log(startVal)
    onEndValChanged: { errorDisplay.enabled = false; projectsModel.refresh(accountIndex, startVal, endVal) }

    Component.onCompleted: projectsModel.refresh(accountIndex)
    Component.onDestruction: projectsModel.clear()

    Connections {
        target: projectsModel
        onGotData: { count = projectCount }
        onGotError: {
            errorDisplay.text = qsTr("Ooops, the following error occured:") + " " + projectsModelErrorString
            errorDisplay.enabled = true
        }
    }

    BusyIndicator {
        anchors.centerIn: parent
        running: visible
        visible: accountsListView.count === 0 && !errorDisplay.enabled
        size: BusyIndicatorSize.Large
    }

    SilicaListView {
        id: accountsListView
        anchors.fill: parent

        header: PageHeader { title: qsTr("Projects:") + " " + accountName }

        VerticalScrollDecorator {}

        PullDownMenu {
            MenuItem {
                text: qsTr("Previous")
                enabled: startVal > 1
                onClicked: {
                    startVal -= 500
                    endVal -= 500
                }
            }
        }

        model: projectsModel
        delegate: ProjectsDelegate {}

        PushUpMenu {
            MenuItem {
                text: qsTr("Next")
                enabled: count >= 500
                onClicked: {
                    startVal += 500
                    endVal += 500
                }
            }
        }

        ViewPlaceholder {
            id: errorDisplay
            enabled: false
        }
    }
}


