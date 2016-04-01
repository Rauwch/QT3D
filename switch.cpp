#include "switch.h"
#include <limits>


Switch::Switch(int np, int nm, int x, int y, int ang):
    Resistor(0.1,np,nm,x,y,ang,true,1,0)
{
        this->setUp(false);
}

void Switch::toggleSwitch()
{
    if(up){
       value =0.1;
       up=false;
    }else{
        value = std::numeric_limits<float>::infinity();
        up=true;
    }

}



bool Switch::getUp() const
{
    return up;
}

void Switch::setUp(bool value)
{
    up = value;
}

void Switch::openSwitch()
{
    value = std::numeric_limits<float>::infinity();
    up=true;

}

void Switch::closeSwitch()
{
    value =0.1;
    up=false;
}
