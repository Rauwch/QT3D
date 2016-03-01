TEMPLATE = app

QT += 3dcore 3drender 3dinput 3dquick qml quick
CONFIG += c++11

SOURCES += main.cpp \
    window.cpp \
    linker.cpp \
    levels.cpp \
    wire.cpp \
    source.cpp \
    resistor.cpp \
    component.cpp \
    calc.cpp

RESOURCES += qml.qrc \
    images.qrc \
    sounds.qrc \
    objects.qrc \
    text.qrc \
    cubemaps.qrc \
    resource.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    window.h \
    linker.h \
    levels.h \
    wire.h \
    source.h \
    resistor.h \
    component.h \
    calc.h

DISTFILES += \
    bolt.ico

RC_ICONS += bolt.ico
