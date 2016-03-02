#ifndef SOURCE_H
#define SOURCE_H
#include "component.h"


class Source : public Component
{
public:
    Source(float v, int np, int nm,int x,int y,int angle, bool var, int init, int stepSize);
    int getNodep() const;
    void setNodep(int value);

    int getNodem() const;
    void setNodem(int value);



    int getInitial() const;
    void setInitial(int value);

    int getStep() const;
    void setStep(int value);

    bool getVariable() const;
    void setVariable(bool value);

private:
    int nodep, nodem, initial,step;
    bool variable;
};

#endif // SOURCE_H
