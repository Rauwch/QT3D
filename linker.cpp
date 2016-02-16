#include "linker.h"

Linker::Linker(QObject *parent) : QObject(parent)
{
    myHeight = 25;
    mySpeed = 1000;
}

int Linker::getMyHeight() const
{
    return myHeight;
}

void Linker::setMyHeight(int value)
{
    myHeight = value;
    //setMySpeed(20*value);
    emit heightChanged(value);
}

int Linker::getMySpeed() const
{
    return mySpeed;
}

void Linker::setMySpeed(int value)
{
    mySpeed = value;
    emit speedChanged(value);
}
