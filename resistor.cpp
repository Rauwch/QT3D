#include "resistor.h"
#include "component.h"
Resistor::Resistor(float v, int n1, int n2, int x, int y, int angle, bool var, int init, int stepSize)
 : node1(n1),node2(n2), variable(var), initial(init), step(stepSize)
{
    this->setInitialValue(init);
    this->setValue(v);
    this->setXCoord(x);
    this->setYCoord(y);
    this->setAngle(angle);
    this->setButtonDif(0);

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

bool Resistor::getVariable() const
{
    return variable;
}

void Resistor::setVariable(bool value)
{
    variable = value;
}

int Resistor::getInitial() const
{
    return initial;
}

void Resistor::setInitial(int value)
{
    initial = value;
}

int Resistor::getStep() const
{
    return step;
}

void Resistor::setStep(int value)
{
    step = value;
}

int Resistor::getButtonDif() const
{
    return buttonDif;
}

void Resistor::setButtonDif(int value)
{
    buttonDif = value;
}



