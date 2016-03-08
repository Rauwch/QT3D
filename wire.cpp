#include "wire.h"

Wire::Wire(int x, int y, int angle, int length, int node, bool goal, float current)
    :length(length),current(current),node(node), isGoal(goal)
{
    this->setValue(0);
    this->setXCoord(x);
    this->setAngle(angle);
    this->setYCoord(y);
    this->setMatch(false);
    this->setGoalValue(0);
}



int Wire::getLength() const
{
    return length;
}

void Wire::setLength(int value)
{
    length = value;
}

int Wire::getNode() const
{
    return node;
}

void Wire::setNode(int value)
{
    node = value;
}

bool Wire::getIsGoal() const
{
    return isGoal;
}

void Wire::setIsGoal(bool value)
{
    isGoal = value;
}

bool Wire::getMatch() const
{
    return match;
}

void Wire::setMatch(bool value)
{
    match = value;
}



float Wire::getGoalValue() const
{
    return goalValue;
}

void Wire::setGoalValue(float value)
{
    goalValue = value;
}
