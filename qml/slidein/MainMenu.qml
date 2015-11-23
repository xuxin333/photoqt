import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle {

	id: mainmenu

	// Background/Border color
	color: colour.fadein_slidein_bg
	border.width: 1
	border.color: colour.fadein_slidein_border

	// Set position (we pretend that rounded corners are along the bottom edge only, that's why visible y is off screen)
	x: (background.width-width)+1
	y: -1
	visible: false

	// Adjust size
	width: 300
	height: background.height+2

	opacity: 0

	property var allitems: [
		[["heading","",qsTr("General Functions")]],
		[["open", "open", qsTr("Open File")]],
		[["settings", "settings", qsTr("Settings")]],
		[["wallpaper", "settings", qsTr("Set as Wallpaper")]],
		[["slideshow","slideshow",qsTr("Slideshow")],["slideshow","",qsTr("setup")],["slideshowquickstart","",qsTr("quickstart")]],
		[["filter", "filter", qsTr("Filter Images in Folder")]],
		[["metadata", "metadata", qsTr("Show/Hide Metadata")]],
		[["about", "about", qsTr("About PhotoQt")]],
		[["hide", "hide", qsTr("Hide (System Tray)")]],
		[["quit", "quit", qsTr("Quit")]],

		[["heading","",""]],

		[["heading","",qsTr("Image")]],
		[["scale","scale",qsTr("Scale Image")]],
		[["zoom","zoom",qsTr("Zoom")],["zoomin","",qsTr("in")],["zoomout","",qsTr("out")],["zoomreset","",qsTr("reset")],["zoomactual","","1:1"]],
		[["rotate","rotate",qsTr("Rotate")],["rotateleft","",qsTr("left")],["rotateright","",qsTr("right")]],
		[["flip","flip",qsTr("Flip")],["flipH","",qsTr("horizontal")],["flipV","",qsTr("vertical")]],

		[["heading","",""]],

		[["heading","",qsTr("File")]],
		[["rename","rename",qsTr("Rename")]],
		[["copy","copy",qsTr("Copy")]],
		[["move","move",qsTr("Move")]],
		[["delete","delete",qsTr("Delete")]]

	]


	ListView {

		id: mainview

		anchors.fill: parent
		anchors.bottom: helptext.top
		anchors.margins: 10
		model: allitems.length
		delegate: maindeleg

		orientation: ListView.Vertical

	}

	Component {

		id: maindeleg

		ListView {

			id: subview

			property int mainindex: index
			height: 25
			width: childrenRect.width

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
					text: "/"
				}

				Image {
					y: 2.5
					width: ((source!="" || allitems[subview.mainindex][index][0]==="heading") ? val.height*0.5 : 0)
					height: val.height*0.5
					sourceSize.width: width
					sourceSize.height: height
					source: allitems[subview.mainindex][index][1]==="" ? "" : "qrc:/img/mainmenu/" + allitems[subview.mainindex][index][1] + ".png"
					opacity: (settings.trayicon || allitems[subview.mainindex][index][0] !== "hide") ? 1 : 0.5
					visible: (source!="" || allitems[subview.mainindex][index][0]==="heading")
				}

				Text {

					id: val;

					color: (allitems[subview.mainindex][index][0]==="heading") ? "white" : colour.text_inactive
					lineHeight: 1.5

					font.capitalization: (allitems[subview.mainindex][index][0]==="heading") ? Font.SmallCaps : Font.MixedCase

					opacity: enabled ? 1 : 0.5

					font.pointSize: 10
					font.bold: true

					enabled: (settings.trayicon || (allitems[subview.mainindex][index][0] !== "hide" && allitems[subview.mainindex][index][0] !=="heading" && (allitems[subview.mainindex].length === 1 || index > 0)))

					// The spaces guarantee a bit of space betwene icon and text
					text: allitems[subview.mainindex][index][2] + ((allitems[subview.mainindex].length > 1 && index == 0) ? ":" : "")

					MouseArea {

						anchors.fill: parent

						hoverEnabled: true
						cursorShape: (allitems[subview.mainindex][index][0]!=="heading" && (allitems[subview.mainindex].length === 1 || index > 0)) ? Qt.PointingHandCursor : Qt.ArrowCursor

						onEntered: {
							if(allitems[subview.mainindex][index][0]!=="heading" && (allitems[subview.mainindex].length === 1 || index > 0))
								val.color = colour.text
						}
						onExited: {
							if(allitems[subview.mainindex][index][0]!=="heading" && (allitems[subview.mainindex].length === 1 || index > 0))
								val.color = colour.text_inactive
						}
						onClicked: {
							if(allitems[subview.mainindex][index][0]!=="heading" && (allitems[subview.mainindex].length === 1 || index > 0))
								mainmenuDo(allitems[subview.mainindex][index][0])
						}

					}

				}

			}

		}

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

		text: qsTr("Click here to go to the online manual for help regarding shortcuts, settings, features, ...")

		MouseArea {
			anchors.fill: parent
			cursorShape: Qt.PointingHandCursor
			onClicked: getanddostuff.openLink("http://photoqt.org/man")
		}

	}

	// Do stuff on clicking on an entry
	function mainmenuDo(what) {

		verboseMessage("MainMenu::mainmenuDo()",what)

		// Hide menu when an entry was clicked
//		if(what !== "metadata") hideMainmenu.start()

		if(what === "open") openFile()

		else if(what === "quit") quitPhotoQt()

		else if(what === "about") about.showAbout()

		else if(what === "settings") settingsitem.showSettings()

		else if(what === "wallpaper") wallpaper.showWallpaper()

		else if(what === "slideshow") slideshow.showSlideshow()

		else if(what === "slideshowquickstart") slideshow.quickstart()

		else if(what === "filter") filter.showFilter()

		else if(what === "metadata") {
			if(metaData.x > -2*metaData.radius) {
				metaData.uncheckCheckbox()
				background.hideMetadata()
			} else {
				metaData.checkCheckbox()
				background.showMetadata(true)
			}
		}
	}

	// 'Hide' animation
	PropertyAnimation {
		id: hideMainmenu
		target: mainmenu
		property: "opacity"
		to: 0
		onStopped: {
			if(opacity == 0 && !showMainmenu.running)
				visible = false
		}
	}

	PropertyAnimation {
		id: showMainmenu
		target:  mainmenu
		property: "opacity"
		to: 1
		onStarted: visible=true
	}

	function show() {
		showMainmenu.start()
	}
	function hide() {
		hideMainmenu.start()
	}

}
