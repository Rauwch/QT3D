#ifndef WIRE_H
#define WIRE_H
#include "component.h"

class Wire : public Component
{
public:
    Wire(int x, int y, int angle, int length,int node, bool goal, float current=0.0);

    int getLength() const;
    void setLength(int value);


    int getNode() const;
    void setNode(int value);

    bool getIsGoal() const;
    void setIsGoal(bool value);

    bool getMatch() const;
    void setMatch(bool value);

    int getNode1() const;
    int getNode2() const;

    float getGoalValue() const;
    void setGoalValue(float value);

private:
    int length,node;
    float current,goalValue;
    bool isGoal, match;
};

#endif // WIRE_H
