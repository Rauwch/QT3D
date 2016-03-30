#ifndef CALC_H
#define CALC_H
#include <vector>
#include <memory>
#include <QFile>
#include "resistor.h"
#include "source.h"
#include "switch.h"
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
    Q_INVOKABLE bool solveLevel();

    //Nodes
    Q_INVOKABLE int numberOfNodes(){return sol.size();}
    Q_INVOKABLE float voltageAtNode(int nodeNr){return sol.at(nodeNr);}

    //Resistors
    Q_INVOKABLE int getNumberOfResistors(){return resistors.size();}
    Q_INVOKABLE float resistanceAtResistor(int resNr){return resistors.at(resNr)->getValue();}
    Q_INVOKABLE float getCurrentofResistor(int resNr){return resistors.at(resNr)->getCurrent();}
    Q_INVOKABLE bool getResistorIsVariable(int resNr){return resistors.at(resNr)->getVariable();}
    Q_INVOKABLE int getAngleOfResistor(int resNr){return resistors.at(resNr)->getAngle();}
    Q_INVOKABLE int getXCoordOfResistor(int resNr){return resistors.at(resNr)->getXCoord();}
    Q_INVOKABLE int getYCoordOfResistor(int resNr){return resistors.at(resNr)->getYCoord();}
    Q_INVOKABLE int node1AtResistor(int resNr){return resistors.at(resNr)->getNode1();}
    Q_INVOKABLE int node2AtResistor(int resNr){return resistors.at(resNr)->getNode2();}
    Q_INVOKABLE int getStepOfResistor(int resNr){return resistors.at(resNr)->getStep();}
    Q_INVOKABLE void adjustResistance(int resNr,int step){resistors.at(resNr)->setValue(resistanceAtResistor(resNr)+step);}


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
    Q_INVOKABLE bool getSourceIsVariable(int sourceNr){return sources.at(sourceNr)->getVariable();}

    //Goals
    Q_INVOKABLE int getNumberOfGoals(){return goals.size();}
    Q_INVOKABLE void setVoltageAtGoal(int goalNr,float voltage){goals.at(goalNr)->setVoltage(voltage);}
    Q_INVOKABLE int nodeAtGoal(int goalNr){return goals.at(goalNr)->getNode();}
    Q_INVOKABLE GoalVoltage getGoal(int goalNr){ return *goals.at(goalNr);}
    Q_INVOKABLE float getVoltageAtGoal(int goalNr){return goals.at(goalNr)->getVoltage();}
    Q_INVOKABLE int getXCoordOfGoal(int goalNr){return goals.at(goalNr)->getX();}
    Q_INVOKABLE int getYCoordOfGoal(int goalNr){return goals.at(goalNr)->getY();}
    Q_INVOKABLE bool getMatch(int goalNr){return goals.at(goalNr)->getMatch();}

    // Current Goals
    Q_INVOKABLE void storeCurrentGoals();
    Q_INVOKABLE bool getGoalCurrent(int goalNr){return wires.at(goalNr)->getIsGoal();}
    Q_INVOKABLE float getCurrentInGoalWire(){
        if(currentGoals.size() != 0)
            return currentGoals.at(0)->getCurrent();
        return 0;
    }
    Q_INVOKABLE float getGoalinGoalWire(){
        if(currentGoals.size() !=0)
            return currentGoals.at(0)->getGoalValue();
        return 0;
    }
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
    void process_switch_line(QString &lijn);
    void process_source_line(QString &lijn);
    void process_click_line(QString &lijn);

    //Check all the goals
    Q_INVOKABLE bool checkGoals();


    //angle calculations for resistor bends
    Q_INVOKABLE float getBendX(int length, float angleYZ, float angleXY){return length*cos(angleYZ)*sin(angleXY);}
    Q_INVOKABLE float getBendY(int length, float angleYZ, float angleXY){return length*cos(angleYZ)*cos(angleXY);}
    //Q_INVOKABLE float getBendZ(int length, float angleYZ, float angleXY){return length*sin(angleYZ);}
    Q_INVOKABLE float calcSin(float length, float angle){return (length*(sin(angle/57.2958)));}
    Q_INVOKABLE float calcCos(float length, float angle){return (length*(cos(angle/57.2958)));}
    Q_INVOKABLE float calcLength(float length, float angle){return (length/(cos(angle/57.2958)));}
    Q_INVOKABLE float getRealSin(float angle){return sin(angle/57.2958);}
    Q_INVOKABLE float getRealCos(float angle){return cos(angle/57.2958);}




    Q_INVOKABLE void setCurrentsOfResistorsAndSwitches();
    Q_INVOKABLE bool setCurrentsOfStrayWires();
    void setCurrentsOfSwitchedWires();

    //switches
    Q_INVOKABLE int getNumberOfSwitches(){return switches.size();}
    Q_INVOKABLE int getAngleOfSwitch(int sw){return switches.at(sw)->getAngle();}
    Q_INVOKABLE int getXCoordOfSwitch(int sw){return switches.at(sw)->getXCoord();}
    Q_INVOKABLE int getYCoordOfSwitch(int sw){return switches.at(sw)->getYCoord();}
    Q_INVOKABLE int node1AtSwitch(int sw){return switches.at(sw)->getNode1();}
    Q_INVOKABLE int node2AtSwitch(int sw){return switches.at(sw)->getNode2();}
    Q_INVOKABLE void toggleSwitch(int sw){ switches.at(sw)->toggleSwitch();}

    Q_INVOKABLE int getTwoStar() const;
    Q_INVOKABLE int getThreeStar() const;

    Q_INVOKABLE int getPhysicalScreenWidth();
    Q_INVOKABLE void printScreenInfo();

private:
    int twoStar;
    int threeStar;

    std::vector<float> computeNetwork(int nrOfNodes);

    //variables for circuit
    std::vector<float> sol;
    std::vector<std::shared_ptr<Source>> sources;
    std::vector<std::shared_ptr<Resistor>> resistors;
    std::vector<std::shared_ptr<Switch>> switches;
    std::vector<std::shared_ptr<Wire>> wires;
    std::vector<std::shared_ptr<GoalVoltage>> goals;
    std::vector<std::shared_ptr<Wire>> currentGoals;
    QString fileName;

};

#endif // CALC_H
