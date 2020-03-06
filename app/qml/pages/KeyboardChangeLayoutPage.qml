/*
 * Copyright 2019 Lieven Hey <t.schilling@snafu.de>.
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

Page {
    allowedOrientations: Orientation.All

    SilicaFlickable {
        anchors.fill: parent

        Column {
            anchors.fill: parent

            PageHeader {
                title: i18n("Settings")
            }

            Slider {
                width: parent.width
                minimumValue: 50
                maximumValue: 500
                stepSize: 50
                value: keyboardLayout.repeatInterval
                valueText: i18n("%1ms repeat interval").arg(value)

                onValueChanged: {
                    if (keyboardLayout.repeatInterval !== value) keyboardLayout.repeatInterval = value
                }
            }

            TextSwitch {
                text: i18n("Vibration feedback")
                checked: keyboardLayout.feedback

                onCheckedChanged: {
                    if (keyboardLayout.feedback !== checked) keyboardLayout.feedback = checked
                }
            }

            ComboBox {
                label: i18n("Change layout")
                currentIndex: getLayoutIndex(keyboardLayout.layout)
                menu: ContextMenu {
                    Repeater {
                        id: view
                        model: keyboardLayout.layouts()

                        delegate: MenuItem {
                            width: view.width
                            height: Theme.itemSizeSmall
                            text: modelData["long"]

                            onClicked: {
                                keyboardLayout.layout = modelData["short"]
                            }
                        }
                    }
                }

                function getLayoutIndex(name) {
                    for (var i = 0; i < keyboardLayout.layouts().length; i++) {
                        if (keyboardLayout.layouts()[i]["short"] === name) {
                            return i
                        }
                    }
                    return 0
                }
            }
        }
    }
}
