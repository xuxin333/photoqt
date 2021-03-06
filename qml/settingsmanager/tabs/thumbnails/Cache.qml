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

import "../../../elements"
import "../../"

Entry {

    title: em.pty+qsTr("Thumbnail Cache")
    helptext: em.pty+qsTr("Thumbnails can be cached in two different ways:") + "<br>" +
              //: This refers to a type of cache for the thumbnails
              em.pty+qsTr("1) File Caching (following the freedesktop.org standard)") + "<br>" +
              //: This refers to a type of cache for the thumbnails
              em.pty+qsTr("2) Database Caching") + "<br><br>" +
              //: The two ways are the two types of thumbnail caching (files and database)
              em.pty+qsTr("Both ways have their advantages and disadvantages:") + "<br>" +
              //: The caching here refers to thumbnail caching
              em.pty+qsTr("File Caching is done according to the freedesktop.org standard and thus different applications can share the same\
 thumbnail for the same image file.") + "<br>" +
              //: The caching here refers to thumbnail caching
              em.pty+qsTr("Database Caching doesn't have the advantage of sharing thumbnails with other applications (and thus every thumbnails has\
 to be newly created for PhotoQt), but it allows PhotoQt to have more control over existing thumbnails and works better on systems like Windows.") +
              "<br><br>" +
              //: The options talked about are the two ways to cache thumbnails (files and database)
              em.pty+qsTr("PhotoQt works with either option, though the first way is set as default and strongly recommended.") + "<br><br>" +
              //: Talking about thumbnail caching with its two possible options, files and database caching
              em.pty+qsTr("Although everybody is encouraged to use at least one of the two options, caching can be completely disabled altogether.\
 However, this means that each thumbnail has to be recreated everytime it is needed.")

    content: [

        CustomCheckBox {
            id: cache
            //: The caching here refers to thumbnail caching
            text: em.pty+qsTr("Enable Cache")
        },

        Item { width: 10; height: 1 },

        Column {

            Rectangle {

                width: childrenRect.width
                height: childrenRect.height
                x: (parent.width-width)/2

                color: "#00000000"

                Row {

                    spacing: 10

                    ExclusiveGroup { id: cachegroup; }

                    CustomRadioButton {
                        id: cache_file
                        //: The caching here refers to thumbnail caching
                        text: em.pty+qsTr("File Caching")
                        enabled: cache.checkedButton
                        exclusiveGroup: cachegroup
                    }
                    CustomRadioButton {
                        id: cache_db
                        //: The caching here refers to thumbnail caching
                        text: em.pty+qsTr("Database Caching")
                        enabled: cache.checkedButton
                        exclusiveGroup: cachegroup
                    }

                }

            }

            Item { width: 1; height: 5 }

            Rectangle {

                width: childrenRect.width
                height: childrenRect.height
                x: (parent.width-width)/2

                color: "#00000000"

                Row {
                    spacing: 5
                    Text {
                        font.pointSize: 10
                        color: cache.checkedButton&&cache_db.checked ? colour.text : colour.text_disabled
                        Behavior on color { ColorAnimation { duration: variables.animationSpeed/2 } }
                        //: The database refers to the database used for caching thumbnail images
                        text: em.pty+qsTr("Database filesize:")
                    }
                    Text {
                        font.pointSize: 10
                        id: db_filesize
                        enabled: cache_db.checked
                        color: cache.checkedButton&&cache_db.checked ? colour.text : colour.text_disabled
                        Behavior on color { ColorAnimation { duration: variables.animationSpeed/2 } }
                        text: "0 KB"
                    }
                }
            }


            Rectangle {

                width: childrenRect.width
                height: childrenRect.height
                x: (parent.width-width)/2

                color: "#00000000"

                Row {
                    spacing: 5
                    Text {
                        font.pointSize: 10
                        enabled: cache_db.checked
                        color: cache.checkedButton&&cache_db.checked ? colour.text : colour.text_disabled
                        Behavior on color { ColorAnimation { duration: variables.animationSpeed/2 } }
                        //: The database refers to the database used for caching thumbnail images (the entries)
                        text: em.pty+qsTr("Entries in database:")
                    }
                    Text {
                        font.pointSize: 10
                        id: db_entries
                        enabled: cache_db.checked
                        color: cache.checkedButton&&cache_db.checked ? colour.text : colour.text_disabled
                        Behavior on color { ColorAnimation { duration: variables.animationSpeed/2 } }
                        text: "0"
                    }
                }

            }

        },

        Item { width: 10; height: 1 },

        Row {

            spacing: 10

            CustomButton {

                id: cleanup
                height: 35
                y: (parent.height-height)/2
                //: Refers to cleaning up the database for thumbnail caching
                text: em.pty+qsTr("CLEAN UP")

                enabled: cache.checkedButton&&cache_db.checked

                onClickedButton: confirmclean.show()

            }

            CustomButton {

                id: erase
                height: 35
                y: (parent.height-height)/2
                //: Refers to emptying the database for thumbnail caching
                text: em.pty+qsTr("ERASE")

                enabled: cache.checkedButton&&cache_db.checked

                onClickedButton: confirmerase.show()

            }


        }

    ]

    function updateDatabaseInfo() {

        verboseMessage("SettingsManager/Thumbnails/Cache", "updateDatabaseInfo()")

        var filesize = thumbnailmanagement.getDatabaseFilesize()
        if(filesize < 1024)
            db_filesize.text = filesize + " KB"
        else
            db_filesize.text = Math.round(filesize*100/1024)/100 + " MB"
        db_entries.text = thumbnailmanagement.getNumberDatabaseEntries()

    }

    function setData() {
        cache.checkedButton = settings.thumbnailCache
        cache_file.checked = settings.thumbnailCacheFile
        cache_db.checked = !settings.thumbnailCacheFile
        updateDatabaseInfo()
    }

    function saveData() {
        settings.thumbnailCache = cache.checkedButton
        settings.thumbnailCacheFile = cache_file.checked
    }

}
