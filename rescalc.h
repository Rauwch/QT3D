#ifndef RESCALC_H
#define RESCALC_H
#include <math.h>
#include <QObject>

class ResCalc: public QObject
{
public:
       ResCalc();
Q_OBJECT

    Q_INVOKABLE float calcSin(float length, float angle){return (length*(sin(angle/57.2958)));}
    Q_INVOKABLE float calcCos(float length, float angle){return (length*(cos(angle/57.2958)));}
    Q_INVOKABLE float calcLength(float length, float angle){return (length/(cos(angle/57.2958)));}
    Q_INVOKABLE float getRealSin(float angle){return sin(angle/57.2958);}
    Q_INVOKABLE float getRealCos(float angle){return cos(angle/57.2958);}

private:

};

#endif // RESCALC_H
