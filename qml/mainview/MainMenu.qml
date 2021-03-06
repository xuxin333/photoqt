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

import "../elements"

Rectangle {

    id: mainmenu

    // Background/Border color
    color: colour.fadein_slidein_bg
    border.width: 1
    border.color: colour.fadein_slidein_border

    // Set position (we pretend that rounded corners are along the bottom edge only, that's why visible y is off screen)
    x: (background.width-width)+1
    y: -1

    // Adjust size
    width: settingsMainMenuWindowWidth
    height: background.height+2

    opacity: 0
    visible: opacity != 0
    Behavior on opacity { NumberAnimation { duration: variables.animationSpeed } }

    // make sure settings values are valid
    property int settingsQuickInfoCloseXSize: Math.max(5, Math.min(25, settings.quickInfoCloseXSize))
    property int settingsMainMenuWindowWidth: Math.max(Math.min(settings.mainMenuWindowWidth, background.width/2), 300)

    // This mouseare catches all mouse movements and prevents them from being passed on to the background
    MouseArea { anchors.fill: parent; hoverEnabled: true }

    property var allitems_static: [
        //: This is an entry in the main menu on the right. Keep short!
        [["__open", "open", em.pty+qsTranslate("MainMenu", "Open File"), "hide"]],
        //: This is an entry in the main menu on the right. Keep short!
        [["__settings", "settings", em.pty+qsTranslate("MainMenu", "Settings"), "hide"]],
        //: This is an entry in the main menu on the right. Keep short!
        [["__wallpaper", "settings", em.pty+qsTranslate("MainMenu", "Set as Wallpaper"), "hide"]],
        //: This is an entry in the main menu on the right. Keep short!
        [["slideshow","slideshow",em.pty+qsTranslate("MainMenu", "Slideshow")],
                //: This is an entry in the main menu on the right, used as in 'setting up a slideshow'. Keep short!
                ["__slideshow","",em.pty+qsTranslate("MainMenu", "setup"), "hide"],
                //: This is an entry in the main menu on the right, used as in 'quickstarting a slideshow'. Keep short!
                ["__slideshowQuick","",em.pty+qsTranslate("MainMenu", "quickstart"), "hide"]],
        //: This is an entry in the main menu on the right. Keep short!
        [["__filterImages", "filter", em.pty+qsTranslate("MainMenu", "Filter Images in Folder"), "hide"]],
        //: This is an entry in the main menu on the right. Keep short!
        [["__hideMeta", "metadata", em.pty+qsTranslate("MainMenu", "Show/Hide Metadata"), "donthide"]],
        //: This is an entry in the main menu on the right. Keep short!
        [["__histogram", "histogram", em.pty+qsTranslate("MainMenu", "Show/Hide Histogram"), "donthide"]],
        //: This is an entry in the main menu on the right. Keep short!
        [["__tagFaces", "faces", em.pty+qsTranslate("MainMenu", "Face tagging mode"), "hide"]],
        //: This is an entry in the main menu on the right. Keep short!
        [["__about", "about", em.pty+qsTranslate("MainMenu", "About PhotoQt"), "hide"]],
        //: This is an entry in the main menu on the right. Keep short!
        [["__close", "hide", em.pty+qsTranslate("MainMenu", "Hide (System Tray)"), "hide"]],
        //: This is an entry in the main menu on the right. Keep short!
        [["__quit", "quit", em.pty+qsTranslate("MainMenu", "Quit"), "hide"]],

        [["heading","",""]],

        //: This is an entry in the main menu on the right, used as in 'Go To some image'. Keep short!
        [["","goto",em.pty+qsTranslate("MainMenu", "Go to")],
                //: This is an entry in the main menu on the right, used as in 'go to previous image'. Keep short!
                ["__prev","",em.pty+qsTranslate("MainMenu", "previous"), "donthide"],
                //: This is an entry in the main menu on the right, used as in 'go to next image'. Keep short!
                ["__next","",em.pty+qsTranslate("MainMenu", "next"), "donthide"],
                //: This is an entry in the main menu on the right, used as in 'go to first image'. Keep short!
                ["__gotoFirstThb","",em.pty+qsTranslate("MainMenu", "first"), "donthide"],
                //: This is an entry in the main menu on the right, used as in 'go to last image'. Keep short!
                ["__gotoLastThb","",em.pty+qsTranslate("MainMenu", "last"), "donthide"]],
        //: This is an entry in the main menu on the right, used as in 'Zoom image'. Keep short!
        [["zoom","zoom",em.pty+qsTranslate("MainMenu", "Zoom")],
                ["__zoomIn","","+", "donthide"],
                ["__zoomOut","","-", "donthide"],
                ["__zoomReset","","0", "donthide"],
                ["__zoomActual","","1:1", "donthide"]],
        //: This is an entry in the main menu on the right, used as in 'Rotate image'. Keep short!
        [["rotate","rotate",em.pty+qsTranslate("MainMenu", "Rotate")],
                //: This is an entry in the main menu on the right, used as in 'Rotate image left'. Keep short!
                ["__rotateL","",em.pty+qsTranslate("MainMenu", "left"), "donthide"],
                //: This is an entry in the main menu on the right, used as in 'Rotate image right'. Keep short!
                ["__rotateR","",em.pty+qsTranslate("MainMenu", "right"), "donthide"],
                //: This is an entry in the main menu on the right, used as in 'Reset rotation of image'. Keep short!
                ["__rotate0","",em.pty+qsTranslate("MainMenu", "reset"), "donthide"]],
        //: This is an entry in the main menu on the right, used as in 'Flip/Mirror image'. Keep short!
        [["flip","flip",em.pty+qsTranslate("MainMenu", "Flip")],
                //: This is an entry in the main menu on the right, used as in 'Flip/Mirror image horizontally'. Keep short!
                ["__flipH","",em.pty+qsTranslate("MainMenu", "horizontal"), "donthide"],
                //: This is an entry in the main menu on the right, used as in 'Flip/Mirror image vertically'. Keep short!
                ["__flipV","",em.pty+qsTranslate("MainMenu", "vertical"), "donthide"],
                //: This is an entry in the main menu on the right, used as in 'Reset flip/mirror of image'. Keep short!
                ["__flipReset","",em.pty+qsTranslate("MainMenu", "reset"), "donthide"]],
        //: This is an entry in the main menu on the right, used to refer to the current file (specifically the file, not directly the image).
        //: Keep short!
        [["","copy",em.pty+qsTranslate("MainMenu", "File")],
                //: This is an entry in the main menu on the right, used as in 'rename file'. Keep short!
                ["__rename","",em.pty+qsTranslate("MainMenu", "rename"), "hide"],
                //: This is an entry in the main menu on the right, used as in 'copy file'. Keep short!
                ["__copy","",em.pty+qsTranslate("MainMenu", "copy"), "hide"],
                //: This is an entry in the main menu on the right, used as in 'move file'. Keep short!
                ["__move","",em.pty+qsTranslate("MainMenu", "move"), "hide"],
                //: This is an entry in the main menu on the right, used as in 'delete file'. Keep short!
                ["__delete","",em.pty+qsTranslate("MainMenu", "delete"), "hide"]],

        [["heading","",""]],

        //: This is an entry in the main menu on the right. Keep short!
        [["__scale","scale",em.pty+qsTranslate("MainMenu", "Scale Image"), "hide"]],
        //: This is an entry in the main menu on the right. Keep short!
        [["__defaultFileManager","open",em.pty+qsTranslate("MainMenu", "Open in default file manager"), "donthide"]]
    ]
    property var allitems_external: []
    property var allitems: []

    // An 'x' to close photoqt
    Rectangle {

        // Position it
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 1
        anchors.topMargin: 1

        // Width depends on type of 'x'
        width: 3*settingsQuickInfoCloseXSize
        height: 3*settingsQuickInfoCloseXSize

        // Invisible rectangle
        color: "#00000000"

        // Fancy 'x'
        Image {

            id: img_x

            anchors.right: parent.right
            anchors.top: parent.top

            source: "qrc:/img/closingx.png"
            sourceSize: Qt.size(parent.width, parent.height)

        }

        // Click on it
        ToolTip {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            text: em.pty+qsTranslate("MainMenu", "Close PhotoQt")
            onClicked:
                mainwindow.closePhotoQt()
        }

    }


    Text {

        id: heading
        y: 10
        x: (parent.width-width)/2
        font.pointSize: 15
        color: colour.text
        font.bold: true
        text: em.pty+qsTranslate("MainMenu", "Main Menu")

    }

    Rectangle {
        id: spacingbelowheader
        x: 5
        y: heading.y+heading.height+10
        height: 1
        width: parent.width-10
        color: "#88ffffff"
    }

    ListView {

        id: mainlistview
        x: 10
        y: spacingbelowheader.y + spacingbelowheader.height+10
        height: parent.height-y-(helptext.height+5)
        width: maxw+20
        model: allitems.length
        delegate: maindeleg
        clip: true

        orientation: ListView.Vertical

    }

    property int maxw: 0

    Component {

        id: maindeleg

        ListView {

            Component.onCompleted:
                if(width > maxw) maxw = width

            id: subview

            property int mainindex: index
            height: 30
            width: childrenRect.width

            interactive: false

            orientation: Qt.Horizontal
            spacing: 5

            model: allitems[mainindex].length
            delegate: Row {

                spacing: 5

                Text {
                    id: sep
                    lineHeight: 1.5

                    color: colour.text_inactive
                    visible: allitems[subview.mainindex].length > 1 && index > 1
                    font.bold: true
                    font.pointSize: 11
                    text: "/"
                }

                Image {
                    y: 2.5
                    width: ((source!="" || allitems[subview.mainindex][index][0]==="heading") ? val.height*0.5 : 0)
                    height: val.height*0.5
                    sourceSize.width: width
                    sourceSize.height: height
                    source: allitems[subview.mainindex][index][1]===""
                            ? "" : (allitems[subview.mainindex][index][0].slice(0,8)==="_:_EX_:_"
                                    ? getanddostuff.getIconPathFromTheme(allitems[subview.mainindex][index][1]) :
                                      "qrc:/img/mainmenu/" + allitems[subview.mainindex][index][1] + ".png")
                    opacity: (settings.trayIcon==1 || allitems[subview.mainindex][index][0] !== "hide") ? 1 : 0.5
                    visible: (source!="" || allitems[subview.mainindex][index][0]==="heading")
                }

                Text {

                    id: val;

                    color: (allitems[subview.mainindex][index][0]==="heading") ? "white" : colour.text_inactive
                    lineHeight: 1.5

                    font.capitalization: (allitems[subview.mainindex][index][0]==="heading") ? Font.SmallCaps : Font.MixedCase

                    opacity: enabled ? 1 : 0.5

                    font.pointSize: 11
                    font.bold: true

                    enabled: (settings.trayIcon==1 || (allitems[subview.mainindex][index][0] !== "__close" &&
                                                       allitems[subview.mainindex][index][0] !=="heading" &&
                                                       (allitems[subview.mainindex].length === 1 || index > 0)))


                    // The spaces guarantee a bit of space betwene icon and text
                    text: allitems[subview.mainindex][index][2] + ((allitems[subview.mainindex].length > 1 && index == 0) ? ":" : "")

                    MouseArea {

                        anchors.fill: parent

                        hoverEnabled: true
                        cursorShape: (allitems[subview.mainindex][index][0]!=="heading" && (allitems[subview.mainindex].length === 1 || index > 0)) ?
                                         Qt.PointingHandCursor :
                                         Qt.ArrowCursor

                        onEntered: {
                            if(allitems[subview.mainindex][index][0]!=="heading" && (allitems[subview.mainindex].length === 1 || index > 0))
                                val.color = colour.text
                        }
                        onExited: {
                            if(allitems[subview.mainindex][index][0]!=="heading" && (allitems[subview.mainindex].length === 1 || index > 0))
                                val.color = colour.text_inactive
                        }
                        onClicked: {
                            if(allitems[subview.mainindex][index][0]!=="heading" && (allitems[subview.mainindex].length === 1 || index > 0)) {
                                if(allitems[subview.mainindex][index][3] === "hide")
                                    hide()
                                var cmd = allitems[subview.mainindex][index][0]
                                var close = 0
                                if(cmd.slice(0,8) === "_:_EX_:_") {
                                    var parts = (cmd.split("_:_EX_:_")[1]).split("___")
                                    close = parts[0];
                                    cmd = parts[1];
                                }
                                shortcuts.executeShortcut(cmd, close)
                            }
                        }

                    }

                }

            }

        }

    }

    Rectangle {
        anchors {
            bottom: helptext.top
            left: parent.left
            right: parent.right
        }
        height: 1
        color: "#22ffffff"

    }

    Text {

        id: helptext

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        height: 100

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        color: "grey"
        wrapMode: Text.WordWrap

        text: em.pty+qsTranslate("MainMenu", "Click here to go to the online manual for help regarding shortcuts, settings, features, ...")

        ToolTip {
            anchors.fill: parent
            text: "http://photoqt.org/man"
            cursorShape: Qt.PointingHandCursor
            onClicked: getanddostuff.openLink("http://photoqt.org/man")
        }

    }

    MouseArea {
        x: 0
        width: 8
        y: 0
        height: parent.height
        cursorShape: Qt.SplitHCursor
        property int oldMouseX

        onPressed:
            oldMouseX = mouseX

        onReleased:
            settings.mainMenuWindowWidth = parent.width

        onPositionChanged: {
            if (pressed) {
                var w = parent.width + (oldMouseX-mouseX)
                if(w >= 300 && w <= background.width/2)
                    parent.width = w
            }
        }
    }

    Component.onCompleted: setupExternalApps()

    Connections {
        target: watcher
        onCustomMenuEntriesUpdated:
            setupExternalApps()
    }

    function setupExternalApps() {

        verboseMessage("MainView/MainMenu", "setupExternalApps()")

        allitems_external = []

        var c = getanddostuff.getContextMenu()

        for(var i = 0; i < c.length/3; ++i) {
            var bin = getanddostuff.trim(c[3*i].replace("%f","").replace("%u","").replace("%d",""))
            // The icon for Krita is called 'calligrakrita'
            if(bin === "krita")
                bin = "calligrakrita"
            allitems_external.push([["_:_EX_:_" + c[3*i+1] + "___" + c[3*i], bin, c[3*i+2], "donthide"]])
        }

        allitems = allitems_static.concat(allitems_external)
    }

    function show() {
        if(opacity != 1) verboseMessage("MainView/MainMenu", "show()")
        opacity = 1
    }
    function hide() {
        if(opacity == 1) verboseMessage("MainView/MainMenu", "hide()")
        opacity = 0
    }

    function clickInMainMenu(pos) {
        verboseMessage("MainView/MainMenu", "clickInMainMenu(): " + pos)
        var ret = mainmenu.contains(mainmenu.mapFromItem(mainwindow,pos.x,pos.y))
        return ret
    }

    Connections {
        target: variables
        onGuiBlockedChanged: {
            if(variables.guiBlocked && mainmenu.opacity == 1 && !variables.taggingFaces)
                mainmenu.opacity = 0.2
            else if(!variables.guiBlocked && mainmenu.opacity == 0.2)
                mainmenu.opacity = 1
        }
    }

}
