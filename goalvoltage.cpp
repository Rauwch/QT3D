#include "goalvoltage.h"

GoalVoltage::GoalVoltage(int x, int y, int node)
{
    this->setX(x);
    this->setY(y);
    this->setNode(node);
    this->setVoltage(0);
    this->setMatch(false);

}

int GoalVoltage::getX() const
{
    return x;
}

void GoalVoltage::setX(int value)
{
    x = value;
}

int GoalVoltage::getY() const
{
    return y;
}

void GoalVoltage::setY(int value)
{
    y = value;
}

int GoalVoltage::getNode() const
{
    return node;
}

void GoalVoltage::setNode(int value)
{
    node = value;
}

float GoalVoltage::getVoltage() const
{
    return voltage;
}

void GoalVoltage::setVoltage(float value)
{
    voltage = value;
}

bool GoalVoltage::getMatch() const
{
    return match;
}

void GoalVoltage::setMatch(bool value)
{
    match = value;
}
