/*
    BTComponents - QML components shared between various Buschtrommel projects
    Copyright (C) 2014  Buschtrommel/Matthias Fehring
    Contact: Matthias Fehring <kontakt@buschmann23.de>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/

import QtQuick 2.0

ListModel {
    ListElement {
        version: "1.1.0"
        date: 1399895644000
        text: "<ul>
                <li>New: review operations on translation page and in string list context menu</li>
                <li>New: metadata page attached to translation page</li>
                <li>New: context menu on source string on translation page for clipboard operations</li>
                <li>Improved: added hint to open transifex slug</li>
                <li>Improved: better handling of empty string list results</li>
               </ul>"
    }

    ListElement {
        version: "1.0.0"
        date: 1399895644000
        text: "<ul><li>Initial release</li></ul>"
    }
}