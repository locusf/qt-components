import Qt 4.7

Item {
    id:pushbutton
    property string text: "Text"
    property alias tooltipText: tooltip.text;
    signal clicked

    width:Math.max(text.width + 20, 200)
    height:Math.max(text.height + 12, 50)

    BorderImage {
        id: buttonImage
        source: "images/button.png"
        anchors.fill:parent
        border.left:10;
        border.top:10;
        border.right:10;
        border.bottom:10;

    }
    BorderImage {
        id: buttonHoveredImage
        opacity:0
        source: "images/button-" + (mouseRegion.pressed
            ? "active" : "hover") + ".png"
        anchors.fill:parent
        border.left:10;
        border.top:10;
        border.right:10;
        border.bottom:10;
    }
    Text {
        id: text
        anchors.verticalCenter:parent.verticalCenter
        anchors.horizontalCenter:parent.horizontalCenter
        anchors.verticalCenterOffset: mouseRegion.pressed?1:0
        text: pushbutton.text
    }

    // ### I wish to have that as a separate item
    Tooltip {
        id: tooltip;
        anchors.top: pushbutton.bottom;
        anchors.horizontalCenter: pushbutton.horizontalCenter;

        property bool pressDismiss: false;
        shown: (mouseRegion.containsMouse && !pressDismiss);
    }

    MouseArea {
        id: mouseRegion
        hoverEnabled: true
        anchors.fill: parent
        onPressed: { tooltip.pressDismiss = true; }
        onExited: { tooltip.pressDismiss = false; }
        onClicked: { pushbutton.clicked(); }
    }

    states: [

        State {
                name: "Disabled"
            },
            State {
            name: "Highlighted"
            when: mouseRegion.containsMouse
                PropertyChanges { target: buttonHoveredImage; opacity: "1"}
                PropertyChanges { target: buttonImage; opacity: "0"}
                //PropertyChanges { target: text; color: "white"}
            }
    ]
    transitions: [
        /*Transition {
            from: "";
            to: "Pressed"
            NumberAnimation { properties: "opacity"; duration: 30 }
            ColorAnimation { properties: "color"; duration: 30 }
        },*/
        Transition {
            from: "Highlighted";
            to: ""
            NumberAnimation { properties: "opacity"; duration: 130 }
        }
    ]

}
