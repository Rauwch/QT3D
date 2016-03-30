TEMPLATE = app

QT += 3dcore 3drender 3dinput 3dquick qml quick
CONFIG += c++11

SOURCES += main.cpp \
    window.cpp \
    levels.cpp \
    wire.cpp \
    source.cpp \
    resistor.cpp \
    component.cpp \
    calc.cpp \
    goalvoltage.cpp \
    leaderboard.cpp \
    switch.cpp \
    rescalc.cpp


RESOURCES += qml.qrc \
    images.qrc \
    sounds.qrc \
    objects.qrc \
    cubemaps.qrc \
    resource.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    window.h \
    levels.h \
    wire.h \
    source.h \
    resistor.h \
    component.h \
    calc.h \
    goalvoltage.h \
    leaderboard.h \
    switch.h \
    rescalc.h

DISTFILES += \
    bolt.ico

RC_ICONS += bolt.ico
