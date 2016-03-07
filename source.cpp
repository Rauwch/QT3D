#include "source.h"
#include "component.h"
Source::Source(float v, int np, int nm, int x, int y, int angle, int stepSize, bool var, int init)
    : nodep(np), nodem(nm),variable(var), initial(init)

{
    this->setStep(stepSize);
    this->setInitialValue(init);
    this->setValue(v);
    this->setXCoord(x);
    this->setYCoord(y);
    this->setAngle(angle);

}



int Source::getNodep() const
{
    return nodep;
}

void Source::setNodep(int value)
{
    nodep = value;
}

int Source::getNodem() const
{
    return nodem;
}

void Source::setNodem(int value)
{
    nodem = value;
}

int Source::getInitial() const
{
    return initial;
}

void Source::setInitial(int value)
{
    initial = value;
}


bool Source::getVariable() const
{
    return variable;
}

void Source::setVariable(bool value)
{
    variable = value;
}



