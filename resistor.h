#ifndef RESISTOR_H
#define RESISTOR_H
#include "component.h"


class Resistor : public Component
{
public:
    Resistor(float v,int n1,int n2,int x,int y,int angle, bool var, int init, int stepSize);
    int getNode1() const;
    void setNode1(int value);

    int getNode2() const;
    void setNode2(int value);


    bool getVariable() const;
    void setVariable(bool value);

    int getInitial() const;
    void setInitial(int value);

    int getStep() const;
    void setStep(int value);

private:
    int node1,node2;
    bool variable;
    int initial;
    int step;

};

#endif // RESISTOR_H
