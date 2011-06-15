/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 1.0
import com.nokia.symbian 1.1
import Qt.labs.components 1.1
import com.nokia.extras 1.1

FocusScope {
    id: root
    anchors {
        fill: parent
        leftMargin: platformStyle.paddingMedium
        rightMargin: platformStyle.paddingMedium
    }
    focus: true

    property int verticalPadding: Math.max((sectionHeight - itemCellHeight - headingHeight) / 2, 0)
    property real sectionHeight: height / 3
    property int itemCellHeight: privateStyle.buttonSize
    property int headingHeight: platformStyle.fontSizeSmall

    InfoBanner {
        id: info
        interactive: true
        timeout: 1000
    }

    Component {
        id: highlight
        Rectangle {
            visible: GridView.view.activeFocus
            border {color: "steelblue"; width: 5}
            color: "#00000000"; radius: 5
            z: 5
        }
    }

    ListModel {
        id: checkBoxesModel
        ListElement {
            objectName: "CB1"
            title: "CheckBox1"
        }
        ListElement {
            objectName: "CB2"
            title: "CheckBox2"
        }
    }

    Component {
        id: checkBoxesDelegate
        CheckBox {
            objectName: objectName
            width: checkBoxes.cellWidth; height: checkBoxes.cellHeight
            text: title
            onClicked: {
                var statusText = checked ? "on" : "off"
                info.text = title + " turned " + statusText
                info.open()
            }
        }
    }

    Text {
        id: checkBoxesHeading
        anchors.top: root.top
        height: root.headingHeight
        font.pixelSize: platformStyle.fontSizeSmall
        font.family: platformStyle.fontFamilyRegular
        color: platformStyle.colorNormalMid
        text: "CheckBoxes"
    }

    GridView {
        id: checkBoxes
        anchors {
            top: checkBoxesHeading.bottom
            bottom: radioButtonsHeading.top
            topMargin: root.verticalPadding
            bottomMargin: root.verticalPadding
        }
        height: root.itemCellHeight
        width: root.width
        cellWidth: width / 2; cellHeight: root.itemCellHeight
        highlight: highlight
        model: checkBoxesModel
        delegate: checkBoxesDelegate
        KeyNavigation.down: radioButtons
    }

    ListModel {
        id: radioButtonsModel
        ListElement {
            objectName: "RB1"
            title: "RadioButton1"
        }
        ListElement {
            objectName: "RB2"
            title: "RadioButton2"
        }
    }

    Component {
        id: radioButtonsDelegate
        RadioButton {
            objectName: objectName
            width: radioButtons.cellWidth; height: radioButtons.cellHeight

            platformExclusiveGroup: group
            text: title
            onClicked: {
                info.text = title + " selected"
                info.open()
            }
        }
    }

    CheckableGroup { id: group }

    Text {
        id: radioButtonsHeading
        y: root.y + root.sectionHeight
        height: root.headingHeight
        font.pixelSize: platformStyle.fontSizeSmall
        font.family: platformStyle.fontFamilyRegular
        color: platformStyle.colorNormalMid
        text: "RadioButtons"
    }

    GridView {
        id: radioButtons
        anchors {
            top: radioButtonsHeading.bottom
            bottom: buttons.top
            topMargin: root.verticalPadding
            bottomMargin: root.verticalPadding
        }
        width: root.width
        cellWidth: width / 2; cellHeight: root.itemCellHeight
        highlight: highlight
        model: radioButtonsModel
        delegate: radioButtonsDelegate
        KeyNavigation.up: checkBoxes
        KeyNavigation.down: buttons
    }

    ListModel {
        id: buttonsModel
        ListElement {
            objectName: "TOGGLEBTN"
            title: "Toggle Button"
            checkableButton: true
            buttonChecked: false
        }
        ListElement {
            objectName: "PUSHBTN"
            title: "Push Button"
            checkableButton: false
            buttonChecked: false
        }
    }

    Component {
        id: buttonsDelegate
        Button {
            objectName: objectName
            width: buttons.cellWidth; height: buttons.cellHeight
            text: title
            checkable: checkableButton
            checked: buttonChecked
            onClicked: {
                var statusText = title
                if (title == "Toggle Button")
                    statusText += checked ? " checked" : " unchecked"
                else
                    statusText += " pressed"
                info.text = statusText
                info.open()
            }
        }
    }

    Text {
        id: buttonsHeading
        y: root.y + root.sectionHeight * 2
        height: root.headingHeight
        font.pixelSize: platformStyle.fontSizeSmall
        font.family: platformStyle.fontFamilyRegular
        color: platformStyle.colorNormalMid
        text: "Buttons"
    }

    GridView {
        id: buttons
        anchors {
            top: buttonsHeading.bottom
            bottom: root.bottom
            topMargin: root.verticalPadding
            bottomMargin: root.verticalPadding
        }
        width: root.width
        cellWidth: width / 2; cellHeight: root.itemCellHeight
        highlight: highlight
        focus: true
        model: buttonsModel
        delegate: buttonsDelegate
        KeyNavigation.up: radioButtons
    }
}
