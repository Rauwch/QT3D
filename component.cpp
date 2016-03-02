#include "component.h"

//TODO override << operator so that component can be printed
//TODO Overerving deftiger maken

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

int Component::getInitial() const
{
    return initial;
}

void Component::setInitial(int value)
{
    initial = value;
}

int Component::getStep() const
{
    return step;
}

void Component::setStep(int value)
{
    step = value;
}

bool Component::getVariable() const
{
    return variable;
}

void Component::setVariable(bool value)
{
    variable = value;
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
