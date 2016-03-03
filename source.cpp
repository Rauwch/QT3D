#include "source.h"
#include "component.h"
Source::Source(float v, int np, int nm, int x, int y, int angle, bool var, int init, int stepSize)
    : nodep(np), nodem(nm),variable(var), initial(init),step(stepSize)

{
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

int Source::getStep() const
{
    return step;
}

void Source::setStep(int value)
{
    step = value;
}

bool Source::getVariable() const
{
    return variable;
}

void Source::setVariable(bool value)
{
    variable = value;
}



