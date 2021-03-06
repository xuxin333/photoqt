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

import "../../elements"

Rectangle {

    property bool currentlySelected: false

    property var selectedScreens_xfce4: []

    visible: currentlySelected

    color: "#00000000"
    width: childrenRect.width
    height: childrenRect.height

    Column {

        spacing: 5

        // NOTE (tool not existing)
        Text {
            id: xfce4_error
            visible: false
            color: colour.text_warning
            font.pointSize: 10
            width: wallpaper_top.width
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            //: "xfconf-query" and "XFCE4" are fixed names, please don't translate
            text: em.pty+qsTr("Warning: 'xfconf-query' doesn't seem to be available! Are you sure XFCE4 is installed?");
        }

        Rectangle { id: xfce4_error_spacing; color: "#00000000"; width: 1; height: 1; }

        // MONITOR HEADING
        Text {
            id: xfce4_monitor_part_1
            color: colour.text
            font.pointSize: 10
            width: wallpaper_top.width
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            text: em.pty+qsTr("The wallpaper can be set to any of the available monitors (one or any combination).")
        }

        // MONITOR SELECTION
        Rectangle {
            id: xfce4_monitor_part_2
            color: "#00000000"
            width: childrenRect.width
            height: childrenRect.height
            x: (wallpaper_top.width-width)/2
            ListView {
                id: xfce4_monitor
                spacing: 5
                width: childrenRect.width
                height: childrenRect.height-10
                contentHeight: childrenRect.height
                delegate: CustomCheckBox {
                    //: Used as in 'Screen #4'
                    text: em.pty+qsTr("Screen") + " #" + index
                    checkedButton: true
                    fsize: 10
                    Component.onCompleted: {
                        selectedScreens_xfce4[selectedScreens_xfce4.length] = index
                        if(xfce4_monitor.width < width)
                            xfce4_monitor.width = width
                    }
                    onCheckedButtonChanged: {
                        if(checkedButton)
                            selectedScreens_xfce4[selectedScreens_xfce4.length] = index
                        else {
                            var newlist = []
                            for(var i = 0; i < selectedScreens_xfce4.length; ++i)
                                if(selectedScreens_xfce4[i] !== index)
                                    newlist[newlist.length] = selectedScreens_xfce4[i]
                            selectedScreens_xfce4 = newlist
                        }
                        okay.enabled = enDisableEnter()
                    }
                }
                model: ListModel { id: xfce4_monitor_model; }
            }
        }

        Rectangle { id: xfce4_monitor_part_3; color: "#00000000"; width: 1; height: 1; }
        Rectangle { id: xfce4_monitor_part_4; color: "#00000000"; width: 1; height: 1; }

        // PICTURE OPTIONS HEADING
        Text {
            color: colour.text
            font.pointSize: 10
            width: wallpaper_top.width
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            //: 'picture options' refers to options like stretching the image to fill the background, or tile the image, center it, etc.
            text: em.pty+qsTr("There are several picture options that can be set for the wallpaper image.")
        }

        Rectangle { color: "#00000000"; width: 1; height: 1; }

        // PICTURE OPTIONS RADIOBUTTONS
        ExclusiveGroup { id: wallpaperoptions_xfce; }
        Rectangle {
            color: "#00000000"
            width: childrenRect.width
            height: childrenRect.height
            x: (wallpaper_top.width-width)/2
            Column {
                spacing: 10
                CustomRadioButton {
                    //: "Automatic" means automatically choose how to set the image as wallpaper
                    text: em.pty+qsTr("Automatic")
                    property string option: "Automatic"
                    fontsize: 10
                    exclusiveGroup: wallpaperoptions_xfce
                }
                CustomRadioButton {
                    //: "Centered" means set the image centered as wallpaper
                    text: em.pty+qsTr("Centered")
                    property string option: "Centered"
                    fontsize: 10
                    exclusiveGroup: wallpaperoptions_xfce
                }
                CustomRadioButton {
                    //: "Tiled" means repeat the wallpaper image until the full screen is covered
                    text: em.pty+qsTr("Tiled")
                    property string option: "Tiled"
                    fontsize: 10
                    exclusiveGroup: wallpaperoptions_xfce
                }
                CustomRadioButton {
                    //: "Stretched" means make the wallpaper image fill the screen without regard to its aspect ratio
                    text: em.pty+qsTr("Stretched")
                    property string option: "Stretched"
                    fontsize: 10
                    exclusiveGroup: wallpaperoptions_xfce
                }
                CustomRadioButton {
                    //: "Scaled" means that the wallpaper image is scaled to properly fill the screen
                    text: em.pty+qsTr("Scaled")
                    property string option: "Scaled"
                    fontsize: 10
                    exclusiveGroup: wallpaperoptions_xfce
                }
                CustomRadioButton {
                    //: "Zoomed" means that the wallpaper image is zoomed to fill the screen
                    text: em.pty+qsTr("Zoomed")
                    property string option: "Zoomed"
                    fontsize: 10
                    exclusiveGroup: wallpaperoptions_xfce
                    checked: true
                }

            }

        }


    }

    function loadXfce4() {

        verboseMessage("Wallpaper/XFCE4","loadXfce4()")

        var c = getanddostuff.getScreenCount()
        xfce4_monitor_model.clear()

        for(var i = 0; i < c; ++i)
            xfce4_monitor_model.append({ "index" : i })

        // Hide screen selection elements for single screen set-ups
        xfce4_monitor_part_1.visible = (c > 1)
        xfce4_monitor_part_2.visible = (c > 1)
        xfce4_monitor_part_3.visible = (c > 1)
        xfce4_monitor_part_4.visible = (c > 1)

        var ret = getanddostuff.checkWallpaperTool("xfce4")
        xfce4_error.visible = (ret === 1)
        xfce4_error_spacing.visible = (ret === 1)

    }

    function getSelectedScreens() {
        return selectedScreens_xfce4
    }

    function getCurrentText() {
        return wallpaperoptions_xfce.current.option
    }

}
