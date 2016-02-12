#include "linker.h"

Linker::Linker(QObject *parent) : QObject(parent)
{
    myHeight = 25;
}

int Linker::getMyHeight() const
{
    return myHeight;
}

void Linker::setMyHeight(int value)
{
    myHeight = value;
    emit heightChanged(value);
}
