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

private:
    int length,node;
    float current;
    bool isGoal;
};

#endif // WIRE_H
