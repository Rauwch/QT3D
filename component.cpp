#include "component.h"

Component::Component()
{

}

int Component::getNodep() const
{
    return 0;
}

int Component::getNodem() const
{
    return 0;
}

int Component::getNode1() const
{
    return 0;
}

int Component::getNode2() const
{
    return 0;
}

int Component::getAngle() const
{
    return angle;
}

void Component::setAngle(int value)
{
    angle = value;
}

int Component::getXCoord() const
{
    return xCoord;
}

void Component::setXCoord(int value)
{
    xCoord = value;
}

int Component::getYCoord() const
{
    return yCoord;
}

void Component::setYCoord(int value)
{
    yCoord = value;
}

float Component::getCurrent() const
{
    return current;
}

void Component::setCurrent(float value)
{
    current = value;
}

float Component::getInitialValue() const
{
    return initialValue;
}

void Component::setInitialValue(float value)
{
    initialValue = value;
}

int Component::getStep() const
{
    return step;
}

void Component::setStep(int value)
{
    step = value;
}


Component::Component(float v)
{
    this->value = v;
}

float Component::getValue() const
{
    return value;
}

void Component::setValue(float value)
{
    this->value=value;
}

int Component::getLength()
{
    return 1;
}
