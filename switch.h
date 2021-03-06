#ifndef SWITCH_H
#define SWITCH_H
#include "resistor.h"


class Switch : public Resistor
{
public:
    Switch(int np, int nm, int x, int y, int ang);
    void toggleSwitch();

    bool getUp() const;
    void setUp(bool value);

    void openSwitch();
    void closeSwitch();

private:
    bool up;
};

#endif // SWITCH_H
