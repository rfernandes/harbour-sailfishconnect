/*
 * Copyright 2019 Richard Liebscher <richard.liebscher@gmail.com>.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import Sailfish.Silica 1.0
import SailfishConnect.Api 0.7
import SailfishConnect.Share 0.3
import Sailfish.Pickers 1.0

IconListItem {
    title: i18n("Share a file")
    source: "image://theme/icon-m-share"
    visible: _device && _device.loadedPlugins.indexOf("SailfishConnect::SharePlugin") >= 0

    onClicked: pageStack.push(filePickerPage)

    Component {
        id: filePickerPage
        ContentPickerPage {
            title: i18n("Select file to send")
            onSelectedContentPropertiesChanged: {
                _device
                    .plugin("SailfishConnect::SharePlugin")
                    .share(selectedContentProperties.url)
            }
        }
    }
}
