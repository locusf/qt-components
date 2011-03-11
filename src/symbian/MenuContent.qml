/****************************************************************************
**
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project on Qt Labs.
**
** No Commercial Usage
** This file contains pre-release code and may not be distributed.
** You may use this file in accordance with the terms and conditions contained
** in the Technology Preview License Agreement accompanying this package.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** If you have questions regarding the use of this file, please contact
** Nokia at qt-info@nokia.com.
**
****************************************************************************/

import Qt 4.7
import "." 1.0

Item {
    id: root

    property alias content: contentArea.children

    signal itemClicked()

    height: flickableArea.height + 2 * style.current.get("listMargin")
    clip: true

    Style {
        id: style
        styleClass: "MenuContent"
    }

    BorderImage {
        source: style.current.get("background")
        border { left: 20; top: 20; right: 20; bottom: 20 }
        anchors.fill: parent
    }

    ScrollBar {
        flickableItem: flickableArea
        visible: flickableArea.height < flickableArea.contentHeight
        anchors {
            top: flickableArea.top
            right: flickableArea.right
        }
    }

    Flickable {
        id: flickableArea

        property int itemsHidden: menuItemHeight == 0 ? 0 : Math.floor(contentY / menuItemHeight)
        property int menuItemHeight: (contentArea.children[0] == undefined) || (contentArea.children[0].children[0] == undefined)
            ? 1 : contentArea.children[0].children[0].height

        x: style.current.get("listMargin"); y: style.current.get("listMargin")
        height: contentArea.height; width: root.width - 2 * style.current.get("listMargin")
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        contentHeight: contentArea.childrenRect.height
        contentWidth: width

        onItemsHiddenChanged: style.play(Symbian.ItemScroll)

        Item {
            id: contentArea

            width: flickableArea.width
            height: childrenRect.height + 2 * style.current.get("listMargin") > style.current.preferredHeight
                ? (style.current.preferredHeight - ((style.current.preferredHeight) % style.current.get("itemHeight")))
                    : childrenRect.height

            onWidthChanged: {
                for (var i = 0; i < children.length; ++i)
                    children[i].width = width
            }

            Component.onCompleted: {
                for (var i = 0; i < children.length; ++i) {
                    if (children[i].clicked != undefined)
                        children[i].clicked.connect(root.itemClicked)
                }
            }
        }
    }
}
