/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the Qt3D module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL3$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or later as published by the Free
** Software Foundation and appearing in the file LICENSE.GPL included in
** the packaging of this file. Please review the following information to
** ensure the GNU General Public License version 2.0 requirements will be
** met: http://www.gnu.org/licenses/gpl-2.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/
#include <QtGui/QGuiApplication>
#include <QtGui/QScreen>
#include <QtQml/QQmlEngine>
#include <QtQml/QQmlComponent>
#include <QtQuick/QQuickWindow>
#include <QtCore/QUrl>
#include <QDebug>
#include <QQmlContext>
#include <QObject>
#include <QGuiApplication>
#include <QQuickView>
#include <QOpenGLContext>

#include "linker.h"
#include "levels.h"
#include "calc.h"
#include "leaderboard.h"
using namespace std;




int main(int argc, char* argv[])
{

    //Calc* c=new Calc();

    QGuiApplication app(argc, argv);
    foreach (QScreen * screen, QGuiApplication::screens())
        screen->setOrientationUpdateMask(Qt::LandscapeOrientation | Qt::PortraitOrientation |
                                         Qt::InvertedLandscapeOrientation | Qt::InvertedPortraitOrientation);
    qmlRegisterType<Linker>("Link",1,0,"Linker");
    qmlRegisterType<Calc>("Calc",1,0,"Calculator");
    qmlRegisterType<Levels>("Lvl",1,0,"Levels");
    qmlRegisterType<Leaderboard>("LB",1,0,"Levelboard");


    QQmlEngine engine;
    QQmlComponent component(&engine);
    //engine.rootContext()->setContextProperty(QStringLiteral("calculator"),c);
    QQuickWindow::setDefaultAlphaBuffer(true);
    component.loadUrl(QUrl("qrc:/StartScreen.qml"));
    if ( component.isReady() )
        component.create();
    else{

        qWarning() << component.errorString();
    }
    return app.exec();
}
