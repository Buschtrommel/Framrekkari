/*
    Framrekkari - Transifex Client for SailfishOS
    Copyright (C) 2014-2019  Hüssenbergnetz/Matthias Fehring
    https://github.com/Buschtrommel/Framrekkari

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

#ifndef LANGUAGESMODEL_H
#define LANGUAGESMODEL_H

#include "hbnsclanguagemodel.h"

class LanguagesModel : public Hbnsc::LanguageModel
{
    Q_OBJECT
    Q_DISABLE_COPY(LanguagesModel)
public:
    explicit LanguagesModel(QObject *parent = nullptr);
    ~LanguagesModel() override;
};

#endif // LANGUAGESMODEL_H
