/**************************************************************************
 **                                                                      **
 ** Copyright (C) 2018 Lukas Spies                                       **
 ** Contact: http://photoqt.org                                          **
 **                                                                      **
 ** This file is part of PhotoQt.                                        **
 **                                                                      **
 ** PhotoQt is free software: you can redistribute it and/or modify      **
 ** it under the terms of the GNU General Public License as published by **
 ** the Free Software Foundation, either version 2 of the License, or    **
 ** (at your option) any later version.                                  **
 **                                                                      **
 ** PhotoQt is distributed in the hope that it will be useful,           **
 ** but WITHOUT ANY WARRANTY; without even the implied warranty of       **
 ** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        **
 ** GNU General Public License for more details.                         **
 **                                                                      **
 ** You should have received a copy of the GNU General Public License    **
 ** along with PhotoQt. If not, see <http://www.gnu.org/licenses/>.      **
 **                                                                      **
 **************************************************************************/

import QtQuick 2.5
import QtQuick.Controls 1.4

import "./other"
import "../../elements"


Item {

    id: tab_top

    property int titlewidth: 100

    anchors {
        fill: parent
        bottomMargin: 5
    }

    Flickable {

        id: flickable

        clip: true

        anchors.fill: parent

        contentHeight: contentItem.childrenRect.height+20
        contentWidth: maincol.width

        Column {

            id: maincol

            Item { width: 1; height: 10 }

            Text {
                width: flickable.width
                color: "white"
                font.pointSize: 20
                font.bold: true
                text: em.pty+qsTr("Other Settings")
                horizontalAlignment: Text.AlignHCenter
            }

            Item { width: 1; height: 20 }

            Text {
                width: flickable.width
                color: "white"
                font.pointSize: 9
                text: qsTranslate("SettingsManager",
                                  "Move your mouse cursor over (or click on) the different settings titles to see more information.")
                horizontalAlignment: Text.AlignHCenter
            }

            Item { width: 1; height: 30 }

            Rectangle { color: "#88ffffff"; width: tab_top.width; height: 1; }

            Item { width: 1; height: 20 }

            Language { id: language }
            CustomEntries { id: customentries; enabled: !getanddostuff.amIOnWindows() }
            Imgur { id: imgur; }

        }

    }

    function setData() {
        verboseMessage("SettingsManager/TabOther", "setData()")
        language.setData()
        customentries.setData()
        imgur.setData()
    }

    function saveData() {
        verboseMessage("SettingsManager/TabOther", "saveData()")
        language.saveData()
        customentries.saveData()
        imgur.saveData()
    }

}
