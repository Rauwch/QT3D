#ifndef SOURCE_H
#define SOURCE_H
#include "component.h"


class Source : public Component
{
public:
    Source(float v, int np, int nm,int x,int y,int angle, int stepSize, bool var, int init);
    int getNodep() const;
    void setNodep(int value);

    int getNodem() const;
    void setNodem(int value);

    int getInitial() const;
    void setInitial(int value);

    bool getVariable() const;
    void setVariable(bool value);

    int getButtonDif() const;
    void setButtonDif(int value);

private:
    int nodep, nodem, initial, buttonDif;
    bool variable;
};

#endif // SOURCE_H
