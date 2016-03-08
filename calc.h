#ifndef CALC_H
#define CALC_H
#include <vector>
#include <memory>
#include <QFile>
#include "resistor.h"
#include "source.h"
#include "component.h"
#include <QDebug>
#include <QString>
#include "wire.h"
#include "goalvoltage.h"
#include <math.h>


class Calc: public QObject
{
Q_OBJECT

public:
    Calc();


    //Methods invokable from QML,voor tekenen van circuit. TODO verbeteren, teveel functies voor hetzelfde
    Q_INVOKABLE void solveLevel();

    //Nodes
    Q_INVOKABLE int numberOfNodes(){return sol.size();}
    Q_INVOKABLE float voltageAtNode(int nodeNr){return sol.at(nodeNr);}

    //Resistors
    Q_INVOKABLE int getNumberOfResistors(){return resistors.size();}
    Q_INVOKABLE float resistanceAtResistor(int resNr){return resistors.at(resNr)->getValue();}
    Q_INVOKABLE float getCurrentofResistor(int resNr){return resistors.at(resNr)->getCurrent();}
    Q_INVOKABLE int getAngleOfResistor(int resNr){return resistors.at(resNr)->getAngle();}
    Q_INVOKABLE int getXCoordOfResistor(int resNr){return resistors.at(resNr)->getXCoord();}
    Q_INVOKABLE int getYCoordOfResistor(int resNr){return resistors.at(resNr)->getYCoord();}
    Q_INVOKABLE int node1AtResistor(int resNr){return resistors.at(resNr)->getNode1();}
    Q_INVOKABLE int node2AtResistor(int resNr){return resistors.at(resNr)->getNode2();}


    //Sources
    Q_INVOKABLE int getNumberOfSources(){return sources.size();}
    Q_INVOKABLE float getVoltageAtSource(int sourceNr){return sources.at(sourceNr)->getValue();}
    Q_INVOKABLE void adjustVoltageAtSource(int sourceNr,int step){sources.at(sourceNr)->setValue(getVoltageAtSource(sourceNr)+step);}
    Q_INVOKABLE float getCurrentofSource(int sourceNr){return sources.at(sourceNr)->getCurrent();}
    Q_INVOKABLE int getAngleOfSource(int soNr){return sources.at(soNr)->getAngle();}
    Q_INVOKABLE int getXCoordOfSource(int soNr){return sources.at(soNr)->getXCoord();}
    Q_INVOKABLE int getYCoordOfSource(int soNr){return sources.at(soNr)->getYCoord();}
    Q_INVOKABLE int nodePAtSource(int sourceNr){return sources.at(sourceNr)->getNodep();}
    Q_INVOKABLE int nodeMAtSource(int sourceNr){return sources.at(sourceNr)->getNodem();}
    Q_INVOKABLE int getStepOfSource(int sourceNr){return sources.at(sourceNr)->getStep();}

    //Goals
    Q_INVOKABLE int getNumberOfGoals(){return goals.size();}
    Q_INVOKABLE void setVoltageAtGoal(int goalNr,float voltage){goals.at(goalNr)->setVoltage(voltage);}
    Q_INVOKABLE int nodeAtGoal(int goalNr){return goals.at(goalNr)->getNode();}
    Q_INVOKABLE GoalVoltage getGoal(int goalNr){ return *goals.at(goalNr);}
    Q_INVOKABLE float getVoltageAtGoal(int goalNr){return goals.at(goalNr)->getVoltage();}
    Q_INVOKABLE int getXCoordOfGoal(int goalNr){return goals.at(goalNr)->getX();}
    Q_INVOKABLE int getYCoordOfGoal(int goalNr){return goals.at(goalNr)->getY();}

    // Current Goals
    Q_INVOKABLE void storeCurrentGoals();
    Q_INVOKABLE bool getGoalCurrent(int goalNr){return wires.at(goalNr)->getIsGoal();}

    //Wires
    Q_INVOKABLE int getNumberOfWires(){return wires.size();}
    Q_INVOKABLE float getCurrentofWire(int wiNr){return wires.at(wiNr)->getCurrent();}
    Q_INVOKABLE int getAngleOfWire(int wiNr){return wires.at(wiNr)->getAngle();}
    Q_INVOKABLE int getXCoordOfWire(int wiNr){return wires.at(wiNr)->getXCoord();}
    Q_INVOKABLE int getYCoordOfWire(int wiNr){return wires.at(wiNr)->getYCoord();}
    Q_INVOKABLE int getNodeOfWire(int wiNr){return wires.at(wiNr)->getNode();}
    Q_INVOKABLE int getLengthOfWire(int wiNr){return wires.at(wiNr)->getLength();}

    //Read in a new file
    Q_INVOKABLE void readFile(QString s);

    //update
    Q_INVOKABLE void updateSources();
    Q_INVOKABLE void updateResistors();

    //Methode voor juiste richtingen
    void correctAngles();
    void setCurrentsOfResistors();
    Q_INVOKABLE void setCurrentsOfWires();

    //Methodes for reading files
    std::vector<std::shared_ptr<Wire> > process_wire_line(QString& lijn);//TODO remove return type and push_back wires in global wires var
    void process_resistor_line(QString &lijn);
    void process_source_line(QString &lijn);
    void process_goal_line(QString &lijn);

    //Check all the goals
    Q_INVOKABLE bool checkGoals();

    //angle calculations for resistor bends
    Q_INVOKABLE float getBendX(int length, float angleYZ, float angleXY){return length*cos(angleYZ)*sin(angleXY);}
    Q_INVOKABLE float getBendY(int length, float angleYZ, float angleXY){return length*cos(angleYZ)*cos(angleXY);}
    Q_INVOKABLE float getBendZ(int length, float angleYZ, float angleXY){return length*sin(angleYZ);}
    Q_INVOKABLE float calcSin(float length, float angle){return length*(sin(angle/57.2958));}
    Q_INVOKABLE float calcCos(float length, float angle){return length*(cos(angle/57.2958));}
    Q_INVOKABLE float calcLength(float length, float angle){return length/(cos(angle/57.2958));}




private:
    std::vector<float> computeNetwork(int nrOfNodes);

    //variables for circuit
    std::vector<float> sol;
    std::vector<std::shared_ptr<Component>> sources;
    std::vector<std::shared_ptr<Component>> resistors;
    std::vector<std::shared_ptr<Wire>> wires;
    std::vector<std::shared_ptr<GoalVoltage>> goals;
    std::vector<std::shared_ptr<Wire>> currentGoals;
    QString fileName;

};

#endif // CALC_H
