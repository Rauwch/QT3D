#include "linker.h"

Linker::Linker(QObject *parent) : QObject(parent)
{
    myHeight = 10;
}

int Linker::getMyHeight() const
{
    return myHeight;
}

void Linker::setMyHeight(int value)
{
    myHeight = value;
}
