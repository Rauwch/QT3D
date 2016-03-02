#ifndef COMPONENT_H
#define COMPONENT_H


class Component
{
public:
    Component(float v);
    float getValue() const;
    void setValue(float value);
    Component();
    //virtual methods
    virtual int getNodep() const;
    virtual int getNodem() const;

    virtual int getNode1() const;
    virtual int getNode2() const;


    virtual int getAngle() const;
    virtual void setAngle(int value);

    virtual int getXCoord() const;
    virtual void setXCoord(int value);

    virtual int getYCoord() const;
    virtual void setYCoord(int value);

    virtual float getCurrent() const;
    virtual void setCurrent(float value);

    int getInitial() const;
    void setInitial(int value);

    int getStep() const;
    void setStep(int value);

    bool getVariable() const;
    void setVariable(bool value);

protected:
    float value,current;
    int angle,xCoord,yCoord,initial,step;
    bool variable;
};

#endif // COMPONENT_H
