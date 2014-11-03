/* -*- coding: utf-8-unix -*-
 *
 * Copyright (C) 2014 Osmo Salomaa
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
import QtLocation 5.0

import "js/util.js" as Util

MapQuickItem {
    id: tile
    anchorPoint.x: 0
    anchorPoint.y: 0
    height: image.height
    sourceItem: Item {
        Image {
            id: image
            smooth: false
            source: tile.uri
        }
    }
    width: image.width
    property int uid
    property string uri
    function setHeight(props) {
        // Set tile pixel height from corner coordinates.
        var total = Math.pow(2, props.zoom) * 256;
        var height = Util.ycoord2ymercator(props.nwy) -
            Util.ycoord2ymercator(props.swy);
        var height = height / (2*Math.PI) * total;
        image.height = Math.ceil(height - 0.25);
    }
    function setWidth(props) {
        // Set tile pixel width from corner coordinates.
        var total = Math.pow(2, props.zoom) * 256;
        var width = (props.nex - props.nwx) / 360 * total;
        image.width = Math.ceil(width - 0.25);
    }
}
