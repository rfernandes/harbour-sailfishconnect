/**
 * Copyright 2015 Holger Kaelberer <holger.k@elberer.de>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License or (at your option) version 3 or any later version
 * accepted by the membership of KDE e.V. (or its successor approved
 * by the membership of KDE e.V.), which shall act as a proxy
 * defined in Section 14 of version 3 of the license.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
/*
 * Copyright 2018 Richard Liebscher <richard.liebscher@gmail.com>.
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

#include "notifyingapplication.h"

#include <QDebug>
#include <QDataStream>

namespace SailfishConnect {

QDataStream& operator<<(QDataStream& out, const NotifyingApplication& app)
{
    out << app.name << app.icon << app.active << app.blacklistExpression.pattern();
    return out;
}

QDataStream& operator>>(QDataStream& in, NotifyingApplication& app)
{
    QString pattern;
    in >> app.name;
    in >> app.icon;
    in >> app.active;
    in >> pattern;
    app.blacklistExpression.setPattern(pattern);
    return in;
}

QDebug operator<<(QDebug dbg, const NotifyingApplication& a) {
    dbg.nospace() << "{ name=" << a.name
                  << ", icon=" << a.icon
                  << ", active=" << a.active
                  << ", blacklistExpression =" << a.blacklistExpression
                  << " }";
    return dbg.space();
}

} // namespace SailfishConnect
