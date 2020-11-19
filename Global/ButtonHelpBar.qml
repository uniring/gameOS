// gameOS theme
// Copyright (C) 2018-2020 Seth Powell 
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.
// (settings.isHandheld) ? vpx(40) : vpx(18)
import QtQuick 2.0
import QtQuick.Layouts 1.11

Item {
id: root

    Component {
        id: buttonhelpDelegate
        Row {
            spacing: 10
            anchors {
                bottom: (settings.isHandheld) ? parent.bottom : vpx(0); bottomMargin: (settings.isHandheld) ? vpx(30) : vpx(0)
            }
            Image {
                source: "../assets/images/controller/" + processButtonArt(button) + ".png"
                width: (settings.isHandheld) ? vpx(60) : vpx(30)
                height: (settings.isHandheld) ? vpx(60) : vpx(30)
                asynchronous: true
            }
            Text { 
                text: name
                font.family: subtitleFont.name
                font.pixelSize: (settings.isHandheld) ? vpx(32) : vpx(16)
                color: theme.text
                height: parent.height
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    ListView {
        anchors.fill: parent
        model: currentHelpbarModel
        delegate: buttonhelpDelegate
        orientation: ListView.Horizontal
        layoutDirection: Qt.RightToLeft
        spacing: (settings.isHandheld) ? vpx(40) : vpx(20)
    }

    visible: currentHelpbarModel ? true : false

    // Processes the button and will display the correct art based on the button mappings set in Pegasus
    // Necessary as we can't use script in the ListModel
    function processButtonArt(button) {
        var buttonModel;
        switch (button) {
            case "accept":
            buttonModel = (settings.isHandheld) ? api.keys.cancel : api.keys.accept;
            break;
            case "cancel":
            buttonModel = (settings.isHandheld) ? api.keys.accept : api.keys.cancel;
            break;
            case "filters":
            buttonModel = (settings.isHandheld) ? api.keys.details : api.keys.filters;
            break;
            case "details":
            buttonModel = (settings.isHandheld) ? api.keys.filters : api.keys.details;
            break;
            case "nextPage":
            buttonModel = api.keys.nextPage;
            break;
            case "prevPage":
            buttonModel = api.keys.prevPage;
            break;
            case "pageUp":
            buttonModel = api.keys.pageUp;
            break;
            case "pageDown":
                buttonModel = api.keys.pageDown;
                break;
            default:
            buttonModel = api.keys.accept;
        }

        var i;
        for (i = 0; buttonModel.length; i++) {
            if (buttonModel[i].name().includes("Gamepad")) {
            var buttonValue = buttonModel[i].key.toString(16)
            return buttonValue.substring(buttonValue.length-1, buttonValue.length);
            }
        }
    }
    
}