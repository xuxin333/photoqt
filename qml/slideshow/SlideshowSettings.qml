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

FadeInTemplate {

    id: slideshow_top

    heading: em.pty+qsTr("Slideshow Setup")

    // make sure settings values are valid
    property string settingsSlideShowMusicFile: getanddostuff.doesThisExist(settings.slideShowMusicFile) ? settings.slideShowMusicFile : ""

    content: [

        Rectangle { color: "#00000000"; width: 1; height: 1; },

        // DESCRIPTION
        Text {
            color: colour.text
            width: slideshow_top.contentWidth
            wrapMode: Text.WordWrap
            font.pointSize: 10
            text: em.pty+qsTr("There are several settings that can be adjusted for a slideshow, like the time between the image, if and how long\
 the transition between the images should be, and also a music file can be specified that will be played in the background.")
        },
        Text {
            color: colour.text
            width: slideshow_top.contentWidth
            wrapMode: Text.WordWrap
            font.pointSize: 10
            text: em.pty+qsTr("Once you have set the desired options, you can also start a slideshow the next time via 'Quickstart',\
 i.e. skipping this settings window.")
        },

        // TIME BETWEEN IMAGES
        Text {
            color: colour.text
            width: slideshow_top.contentWidth
            wrapMode: Text.WordWrap
            font.pointSize: 15
            font.bold: true
            //: This refers to the time the slideshow waits before loading the next image
            text: em.pty+qsTr("Time in between")
        },
        Text {
            color: colour.text
            width: slideshow_top.contentWidth
            wrapMode: Text.WordWrap
            font.pointSize: 10
            text: em.pty+qsTr("Adjust the time between the images, i.e., how long the slideshow will wait before loading the next image.")
        },

        // Adjust the time in between (slider/spinbox)
        Rectangle {
            color: "#00000000"
            x: (slideshow_top.contentWidth-width)/2
            width: childrenRect.width
            height: childrenRect.height
            Row {
                spacing: 5
                CustomSlider {
                    id: timeslider
                    x: (slideshow_top.contentWidth-width)/2
                    width: slideshow_top.contentWidth/3
                    minimumValue: 1
                    maximumValue: 300
                    scrollStep: 1
                    stepSize: 1
                    value: settings.slideShowTime
                }
                CustomSpinBox {
                    id: timespinbox
                    width: 75
                    minimumValue: 1
                    maximumValue: 300
                    suffix: "s"
                    value: timeslider.value
                    onValueChanged: timeslider.value = value
                }
            }
        },

        // SMOOTH TRANSITION OF IMAGES
        Text {
            color: colour.text
            width: slideshow_top.contentWidth
            wrapMode: Text.WordWrap
            font.pointSize: 15
            font.bold: true
            //: This refers to the transition between two images, how quickly they fade into each other (if at all)
            text: em.pty+qsTr("Smooth Transition")
        },
        Text {
            color: colour.text
            width: slideshow_top.contentWidth
            wrapMode: Text.WordWrap
            font.pointSize: 10
            text: em.pty+qsTr("Here you can set whether you want the images to fade into each other and how fast they are to do that.")
        },

        // Slider to adjust transition time
        Rectangle {
            color: "#00000000"
            x: (slideshow_top.contentWidth-width)/2
            width: childrenRect.width
            height: childrenRect.height
            Row {
                spacing: 5
                Text {
                    color: colour.text
                    font.pointSize: 10
                    //: This refers to the fading between images. No transition means that the new images simply replaces the old image instantly
                    text: em.pty+qsTr("No Transition")
                }
                CustomSlider {
                    id: transitionslider
                    x: (slideshow_top.contentWidth-width)/2
                    width: slideshow_top.contentWidth/3
                    minimumValue: 0
                    maximumValue: 15
                    scrollStep: 1
                    stepSize: 1
                    tickmarksEnabled: true
                    value: settings.slideShowImageTransition
                }
                Text {
                    font.pointSize: 10
                    color: colour.text
                    //: This refers to the fading between images. A long transition means that two images fade very slowly into each other
                    text: em.pty+qsTr("Long Transition")
                }
            }
        },

        // SHUFFLE AND LOOP
        Text {
            color: colour.text
            width: slideshow_top.contentWidth
            wrapMode: Text.WordWrap
            font.pointSize: 15
            font.bold: true
            //: Shuffle means putting the list of all the files in the current folder into random order. Loop means that the slideshow
            //: will start again from the bginning when it reaches the last image.
            text: em.pty+qsTr("Shuffle and Loop")
        },
        Text {
            color: colour.text
            width: slideshow_top.contentWidth
            wrapMode: Text.WordWrap
            font.pointSize: 10
            text: em.pty+qsTr("If you want PhotoQt to loop over all images (i.e., once it shows the last image it starts from the beginning), or\
 if you want PhotoQt to load your images in random order, you can check either or both boxes below. Note in the case of shuffling that no image\
 will be shown twice before every image has been shown once.")
        },

        // Checkboxes to en-/disable it
        CustomCheckBox {
            id: loop
            //: This means that once the last image is reaches PhotoQt will start again from the first one
            text: em.pty+qsTr("Loop over images")
            checkedButton: settings.slideShowLoop
            x: (slideshow_top.contentWidth-width)/2
        },
        CustomCheckBox {
            id: shuffle
            //: This means to put the list of files into random order.
            text: em.pty+qsTr("Shuffle images")
            checkedButton: settings.slideShowShuffle
            x: (slideshow_top.contentWidth-width)/2
        },

        // HIDE QUICKINFOS
        Text {
            color: colour.text
            width: slideshow_top.contentWidth
            wrapMode: Text.WordWrap
            font.pointSize: 15
            font.bold: true
            //: The quickinfo refers to the labels (like position in the folder, filename, closing 'x') that are normally shown on the main image
            text: em.pty+qsTr("Quickinfo")
        },

        Text {
            color: colour.text
            width: slideshow_top.contentWidth
            wrapMode: Text.WordWrap
            font.pointSize: 10
            text: em.pty+qsTr("Depending on your setup, PhotoQt displays some information at the top edge, like position in current directory or\
 file path/name. Here you can disable them temporarily for the slideshow.")
        },

        CustomCheckBox {
            id: quickinfo
            //: The quickinfo refers to the labels (like position in the folder, filename, closing 'x') that are normally shown on the main image
            text: em.pty+qsTr("Hide Quickinfo")
            checkedButton: settings.slideShowHideQuickInfo
            x: (slideshow_top.contentWidth-width)/2
        },

        // BACKGROUND MUSIC
        Text {
            color: colour.text
            width: slideshow_top.contentWidth
            wrapMode: Text.WordWrap
            font.pointSize: 15
            font.bold: true
            text: em.pty+qsTr("Background Music")
        },
        Text {
            color: colour.text
            width: slideshow_top.contentWidth
            wrapMode: Text.WordWrap
            font.pointSize: 10
            text: em.pty+qsTr("Some might like to listen to some music while the slideshow is running. Here you can select a music file\
 you want to be played in the background.")
        },
        // Checkbox to enable music
        CustomCheckBox {
            id: musiccheckbox
            x: (slideshow_top.contentWidth-width)/2
            checkedButton: (settingsSlideShowMusicFile != "")
            text: em.pty+qsTr("Enable Music")
        },
        // Area displaying music file path and option to change it
        Rectangle {
            color: "#14" + (enabled ? colour.text_disabled.substring(1,colour.text_disabled.length) : colour.text.substring(1,colour.text.length))
            width: slideshow_top.contentWidth/2
            enabled: musiccheckbox.checkedButton
            x: slideshow_top.contentWidth/4
            height: musictxt.height+20
            radius: variables.global_item_radius
            border.color: colour.fadein_slidein_border
            Text {
                id: musictxt
                x: 15
                clip: true
                elide: Text.ElideLeft
                width: parent.width-30
                font.pointSize: 10
                y: (parent.height-height)/2
                color: parent.enabled ? colour.text : colour.text_disabled
                text: settingsSlideShowMusicFile
            }
            Text {
                id: emptymusic
                x: 15
                visible: musictxt.text == ""
                width: parent.width-30
                y: (parent.height-height)/2
                font.pointSize: 10
                color: colour.text_disabled
                text: em.pty+qsTr("Click here to select a music file...")
            }
            // Click on area offers option to select new file
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: selectNewMusicFile()
            }
        },

        Rectangle { color: "#00000000"; width: 1; height: 1; }
    ]

    buttons: [
        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width: childrenRect.width
            Row {
                spacing: 10
                CustomButton {
                    id: okay
                    //: In the sense of 'ok, save the slideshow settings and lets start with the slideshow'
                    text: em.pty+qsTr("Start slideshow")
                    onClickedButton: simulateEnter();
                }
                CustomButton {
                    //: In the sense of, 'no, don't save the slideshow settings and don't start a slideshow'
                    text: em.pty+qsTr("Cancel")
                    onClickedButton: hide()
                }
                CustomButton {
                    //: In the sense of 'ok, save the slideshow settings, but do not start a slideshow'
                    text: em.pty+qsTr("Save settings for later")
                    onClickedButton: hideSlideshowAndRememberSettings()
                }
            }
        }
    ]

    Connections {
        target: call
        onSlideshowSettingsShow: {
            if(variables.currentFile === "") return
            showSlideshow()
        }
        onShortcut: {
            if(!slideshow_top.visible) return
            if(sh == "Escape")
                hide()
            else if(sh == "Enter" || sh == "Return")
                simulateEnter()
        }
        onCloseAnyElement:
            if(variables.currentFile !== "")
                hide()
    }

    function selectNewMusicFile() {
        verboseMessage("Slideshow/SlideshowSettings", "selectNewMusicFile()")
        var ret = getanddostuff.getFilename(em.pty+qsTr("Select music file..."), musictxt.text==""?getanddostuff.getHomeDir():musictxt.text,
                                            em.pty+qsTr("Music Files") + " (*.mp3 *.flac *.ogg *.wav);;"
                                            + em.pty+qsTr("All Files") + " (*.*)")
        if(ret !== "")
            musictxt.text = ret
    }

    function simulateEnter() {

        verboseMessage("Slideshow/SlideshowSettings", "simulateEnter()")

        saveSettings()
        hide()

        // The slideshowbar handles the slideshow (as it has an active role during the slideshow)
        call.load("slideshowStart")

    }

    function showSlideshow() {
        verboseMessage("Slideshow/SlideshowSettings", "showSlideshow(): " + variables.currentFile)
        loadSettings()
        show()
    }

    function hideSlideshowAndRememberSettings() {
        verboseMessage("Slideshow/SlideshowSettings", "hideSlideshowAndRememberSettings()")
        saveSettings()
        hide()
    }

    function saveSettings() {
        verboseMessage("Slideshow/SlideshowSettings", "saveSettings()")
        settings.slideShowTime = timeslider.value
        settings.slideShowImageTransition = transitionslider.value
        settings.slideShowLoop = loop.checkedButton
        settings.slideShowShuffle = shuffle.checkedButton
        settings.slideShowHideQuickInfo = quickinfo.checkedButton
        settings.slideShowMusicFile = (musiccheckbox.checkedButton ? musictxt.text : "")
    }
    function loadSettings() {
        verboseMessage("Slideshow/SlideshowSettings", "loadSettings()")
        timeslider.value = settings.slideShowTime
        transitionslider.value = settings.slideShowImageTransition
        loop.checkedButton = settings.slideShowLoop
        shuffle.checkedButton = settings.slideShowShuffle
        quickinfo.checkedButton = settings.slideShowHideQuickInfo
        musiccheckbox.checkedButton = (settingsSlideShowMusicFile!="")
        musictxt.text = settingsSlideShowMusicFile
    }

}
