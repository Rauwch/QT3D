#include "resistor.h"
#include "component.h"
Resistor::Resistor(float v, int n1, int n2, int x, int y, int angle, bool variable, int initial, int step)
 : node1(n1),node2(n2)
{

    this->setValue(v);
    this->setXCoord(x);
    this->setYCoord(y);
    this->setAngle(angle);
    this->setVariable(variable);
    this->setInitial(initial);
    this->setStep(step);
}

int Resistor::getNode1() const
{
    return node1;
}

void Resistor::setNode1(int value)
{
    node1 = value;
}

int Resistor::getNode2() const
{
    return node2;
}

void Resistor::setNode2(int value)
{
    node2 = value;
}



