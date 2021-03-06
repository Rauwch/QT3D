#include "calc.h"
#include<math.h>
#include <vector>
#include <QTextStream>
#include <QPoint>
#include "Eigen/Dense"
#include <QStandardPaths>
#include <QScreen>
#include <QGuiApplication>
#include <limits>

using namespace Eigen;
Calc::Calc()
{
    qDebug() << "Calculator is build";
}
/*function solves the level
  method provided by other team */
bool Calc::solveLevel()
{
    //Build a list of all nodes and sort it
    std::list<int> nodes;

    for(auto& v:sources){
        nodes.push_back(v->getNodem());
        nodes.push_back(v->getNodep());
    }
    for(auto& r:resistors){

        nodes.push_back(r->getNode1());
        nodes.push_back(r->getNode2());
    }
    for(auto& s:switches){

        nodes.push_back(s->getNode1());
        nodes.push_back(s->getNode2());
    }
    nodes.sort();
    nodes.unique();

    //Calculate voltage of all nodes
    sol=computeNetwork(nodes.size());

    //Standardize all angles for easy calculations
    correctAngles();

    //Set currents trough all components
    setCurrentsOfResistorsAndSwitches();
    for(auto& w:wires){
        w->setCurrent(std::numeric_limits<float>::infinity());
    }
    setCurrentsOfWires();

    if(!(setCurrentsOfStrayWires()))
    {
        qDebug()<< "in stray wire if";
        return false;
    }
    return true;

}
/*function stores all wires that are a goal,
  multiple goals can be stored */
void Calc::storeCurrentGoals()
{
    for(unsigned int i = 0; i < wires.size(); i++)
    {
        if(wires.at(i)->getIsGoal())
        {
            currentGoals.push_back(wires.at(i));
            wires.at(i)->setGoalValue(wires.at(i)->getCurrent());
        }
    }
}
/*read in file new,
 * method provided by other team and extended by us */
bool Calc::readFile(QString s)
{
    wires.clear();
    sources.clear();
    resistors.clear();
    switches.clear();
    QFile * file = new QFile(s);
    if (file->open(QIODevice::ReadOnly| QIODevice::Text))
    {
        QTextStream in(file);
        while (!in.atEnd())
        {
            QString line = in.readLine();
            if (!line.isEmpty()&&!line.isNull()){
                /*Determine what to do, depending on the first character*/
                switch (line.at(0).toLower().toLatin1())
                {
                case '*':
                    switch(line.at(1).toLower().toLatin1())
                    {
                    case's':
                        if(line.at(2).toLower().toLatin1()=='w' && line.length()>4){
                            if(!process_switch_line(line))
                                return false;
                        }
                        else{
                            for (int i=2;i<line.length();i++){
                                if(line.at(i).toLower().toLatin1()=='j'){
                                    qDebug()<<"start of file, found correct sj start";
                                }
                            }
                        }
                        break;

                    case 'g':
                        /*Not used anymore, compability with old files*/
                        break;

                    case 'w':
                        /*Read in Wire*/
                        if(line.length()>2){
                            if(!process_wire_line(line))
                                return false;
                        }
                        break;
                    case 'c':
                        /*Read in Click-goals*/
                        if(!process_click_line(line))
                            return false;
                        break;
                    case '/':
                        /*ignore, for file readability*/
                        break;
                    case'*':
                        /*ignore, for comments*/
                        break;


                    default:
                        qDebug()<<"something went wrong" <<"\n";
                        return false;
                        break;
                    }

                    break;


                case '\n':
                    /*just continue*/
                    break;

                case ' ':
                    /*just continue*/
                    break;

                case 'r':
                    /*Read in resistor*/
                    if(!process_resistor_line(line))
                        return false;
                    break;

                case 'v':
                    /*Read in source*/
                    if(!process_source_line(line))
                        return false;
                    break;

                case '.':
                    /*end of file*/
                    break;

                default :
                    qDebug()<<"something went wrong" <<"\n";
                    return false;
                    break;
                }
            }
        }
        file->close();
        return true;
    }

    return false;
}
/* change the  source goal value to the initial value */
void Calc::updateSources()
{
    float v, initial, step, difference;
    for(unsigned int i= 0; i < sources.size(); i++)
    {
        if(sources.at(i)->getInitialValue() != 0)
        {
            v = sources.at(i)->getValue();
            initial = sources.at(i)->getInitial();
            step = sources.at(i)->getStep();
            if(step != 0)
                difference = (v - initial)/ step;
            sources.at(i)->setButtonDif(difference);
            sources.at(i)->setValue(initial);
        }
    }
}
/* change the resistor goal value to the initial value */
void Calc::updateResistors()
{
    float v, initial, step, difference;
    for( unsigned int i= 0; i < resistors.size(); i++)
    {
        if(resistors.at(i)->getInitialValue() != 0)
        {
            v = resistors.at(i)->getValue();
            initial = resistors.at(i)->getInitial();
            step = resistors.at(i)->getStep();
            if(step != 0)
                difference = (v - initial)/ step;
            resistors.at(i)->setButtonDif(difference);
            resistors.at(i)->setValue(initial);
        }
    }
}


/*Read a new wire line and define it
 *method provided by other team and extended by us */
bool Calc::process_wire_line(QString &lijn)
{
    QStringList list;
    int x, y, angle, length, node;
    int xGoal, yGoal, nodeGoal;
    bool isGoal;
    lijn.replace("*","",Qt::CaseSensitivity::CaseInsensitive); //remove *
    lijn.replace("w","",Qt::CaseSensitivity::CaseInsensitive); //remove w
    list=lijn.split(",");
    for (auto& current: list)
    {
        QStringList wireParams=current.split(" ",QString::SkipEmptyParts);
        /*Check for right amount of parameters*/
        if(wireParams.size() == 8)
        {
            x=wireParams.at(1).toInt();
            y=wireParams.at(2).toInt();
            angle=wireParams.at(0).toInt();
            length=wireParams.at(4).toInt();

            if(wireParams.at(7).toInt() == 1)
                isGoal = true;
            else if(wireParams.at(7).toInt() == 0)
                isGoal = false;
            else
                qDebug() << "Wrong entry for variable";
            node=wireParams.at(3).toInt();
            auto w =std::make_shared<Wire>(x,y,angle,length,node,isGoal);
            wires.push_back(w);

            if( wireParams.at(6).toInt() != 0)
            {
                if(wireParams.at(6).toInt() ==1)
                {
                    xGoal = x;
                    yGoal = y;
                    nodeGoal = node;
                }
                else if(wireParams.at(6).toInt() == 2)
                {
                    switch(angle)
                    {
                    case (1):
                        xGoal = x +length;
                        yGoal = y;
                        break;
                    case (2):
                        xGoal = x;
                        yGoal = y + length;
                        break;
                    case (3):
                        xGoal = x - length;
                        yGoal = y;
                        break;
                    case (4):
                        xGoal = x;
                        yGoal = y - length;
                        break;
                    default:
                        break;
                    }
                    nodeGoal = node;
                }
                auto g = std::make_shared<GoalVoltage>(xGoal,yGoal,nodeGoal);
                goals.push_back(g);
            }
        }
        else{
            qDebug()<<"Bad wire";
            return false;
        }
    }
    return true;
}
/*Read a new resistor line and define it,
 *method provided by other team and extended by us */
bool Calc::process_resistor_line(QString &lijn)
{
    int x,y,angle, initial,step,node1,node2;
    float v;
    bool variable;
    lijn.replace("r","",Qt::CaseSensitivity::CaseInsensitive); //remove r
    QStringList list=lijn.split(" ",QString::SkipEmptyParts);
    /*Check for right amount of parameters*/
    if(list.size()==12)
    {
        x=list.at(5).toInt();
        y=list.at(6).toInt();
        angle=list.at(7).toInt();

        if(list.at(8).toInt() == 1)
        {
            variable = true;
        }
        else if(list.at(8).toInt() == 0)
        {
            variable = false;
        }
        else{
            qDebug() << "Wrong entry for variable";
        }
        initial = list.at(9).toInt();
        step = list.at(10).toInt();
        node1 = list.at(1).toInt();
        node2 = list.at(2).toInt();
        v = list.at(3).toFloat();
        auto r =std::make_shared<Resistor>(v,node1,node2,x,y,angle,variable,initial,step);

        resistors.push_back(r);
        return true;
        qDebug() << resistors.size();
    }
    else{

        return false;
    }
}
/*Read a new switch line and define it,
 *method provided by other team and extended by us */
bool Calc::process_switch_line(QString &lijn)
{
    int angle,x,y,node1,node2;
    lijn.replace("*sw","",Qt::CaseSensitivity::CaseInsensitive); //remove *sw
    QStringList list=lijn.split(" ",QString::SkipEmptyParts);

    if(list.size()==5){ //Check for right amount of parameters

        angle=list.at(0).toInt();
        x=list.at(1).toInt();
        y=list.at(2).toInt();
        node1=list.at(3).toInt();
        node2=list.at(4).toInt();

        auto sw =std::make_shared<Switch>(node1,node2,x,y,angle);
        switches.push_back(sw);
        return true;
    }
    else{
        qDebug()<<"Bad switch";
        return false;
    }
}
/*Read a new source line and define it,
 *method provided by other team and extended by us */
bool Calc::process_source_line(QString &lijn)
{ 
    int x,y,angle,initial,step,nodep,nodem;
    bool variable;
    float v;
    lijn.replace("v","",Qt::CaseSensitivity::CaseInsensitive); //remove v
    QStringList list=lijn.split(" ",QString::SkipEmptyParts);
    if(list.size()==12)
    {
        x = list.at(5).toInt();
        y = list.at(6).toInt();
        angle = list.at(7).toInt();
        v = list.at(3).toFloat();
        step = list.at(10).toInt();
        nodep = list.at(1).toInt();
        nodem = list.at(2).toInt();
        if(list.at(8).toInt() == 1)
        {
            variable = true;
            initial = list.at(9).toInt();
        }
        else if(list.at(8).toInt() == 0)
        {
            variable = false;
            initial = v;
        }
        else{
            qDebug() << "Wrong entry for variable";
        }
        auto s =std::make_shared<Source>(v,nodep,nodem,x,y,angle,step,variable,initial);
        sources.push_back(s);
        return true;
    }
    else{
        qDebug()<<"Bad source";
        return false;
    }
}
/*Read a new goal line and it*/
bool Calc::process_click_line(QString &lijn)
{
    lijn.replace("*","",Qt::CaseSensitivity::CaseInsensitive); //remove *
    lijn.replace("c","",Qt::CaseSensitivity::CaseInsensitive); //remove c
    QStringList list=lijn.split(" ");
    if(list.size()==2){ //Check for right amount of parameters

        twoStar = list.at(1).toInt();
        threeStar = list.at(0).toInt();
        return true;
    }
    else{
        qDebug()<<"Bad clickGoal";
        return false;
    }
}
/* method that checks if all the goals are met */
bool Calc::checkGoals()
{
    bool allGoals = true;
    float goalVoltage;
    int goalNode;
    float currentVoltage;
    for(unsigned int i = 0; i < goals.size();i++)
    {
        goalVoltage = goals.at(i)->getVoltage();
        goalNode = goals.at(i)->getNode();
        currentVoltage = voltageAtNode(goalNode);

        //qDebug()  <<"this is the current voltage: " << QString::number(currentVoltage, 'f', 6) << " and the goalVoltage: " << QString::number(goalVoltage,'f', 6);
        /* small difference produced an error */
        if(round(goalVoltage*1000)/1000 != round(currentVoltage*1000)/1000)
        {
            allGoals = false;
            qDebug() << "FALSE goalV " << goalVoltage << "currentV " << currentVoltage;
            goals.at(i)->setMatch(false);
        }
        else
        {
            qDebug() << "TRUE goalV " << goalVoltage << "currentV " << currentVoltage;
            goals.at(i)->setMatch(true);
        }
    }
    float currentCurrent;
    float goalCurrent;
    for(unsigned int i = 0; i <currentGoals.size();i++)
    {
        currentCurrent = currentGoals.at(i)->getCurrent();
        goalCurrent = currentGoals.at(i)->getGoalValue();
        qDebug() << "currentCurrent is: " << QString::number(currentCurrent,'f', 6)  << "  goalCurrent is:  " << QString::number(goalCurrent,'f', 6)  ;
        currentCurrent = round(currentCurrent*1000)/1000;
        goalCurrent = round(goalCurrent*1000)/1000;
        qDebug() << "currentCurrent is: " << QString::number(currentCurrent,'f', 6)  << "  goalCurrent is:  " << QString::number(goalCurrent,'f', 6)  ;
        if(currentCurrent!= goalCurrent)
        {
            qDebug()<< " no match";
            allGoals = false;
            currentGoals.at(i)->setMatch(false);
        }
        else
        {
            qDebug()<< " a match";
            currentGoals.at(i)->setMatch(true);
        }
    }
    return allGoals;
}

/*Functie om hoek te corrigeren*/
void Calc::correctAngles()
{
    //Joined vector with resistors and switches
    std::vector<std::shared_ptr<Component>> swAndR;
    swAndR.insert( swAndR.end(), resistors.begin(), resistors.end());
    swAndR.insert( swAndR.end(), switches.begin(), switches.end());

    //Vector for checking voltage with
    std::vector<std::shared_ptr<Component>> toCheck;
    toCheck.insert( toCheck.end(), wires.begin(), wires.end());
    toCheck.insert(toCheck.end(),swAndR.begin(),swAndR.end());

    //If the lowest voltage isn't at the starting side of the component, turn it around
    for(auto& r:swAndR){
        QPoint p(r->getXCoord(),r->getYCoord());
        int angle = r->getAngle();
        int checkNode1 = -1;
        int checkNode2 = -1;


        for(auto& w: toCheck){
            if(w!=r){
                int xp = w->getXCoord();
                int yp = w->getYCoord();
                int l = w->getLength();
                switch (w->getAngle()) {
                case 1:
                    if(p==QPoint(xp,yp) || p == QPoint(xp+l,yp)){
                        checkNode1 = w->getNode1();
                        checkNode2 = w->getNode2();
                        goto Correct;
                    }

                    break;
                case 2:
                    if(p==QPoint(xp,yp) || p == QPoint(xp,yp+l)){
                        checkNode1 = w->getNode1();
                        checkNode2 = w->getNode2();
                        goto Correct;
                    }

                    break;
                case 3:
                    if(p==QPoint(xp,yp) || p == QPoint(xp-l,yp)){
                        checkNode1 = w->getNode1();
                        checkNode2 = w->getNode2();
                        goto Correct;
                    }

                    break;
                case 4:
                    if(p==QPoint(xp,yp) || p == QPoint(xp,yp-l)){
                        checkNode1 = w->getNode1();
                        checkNode2 = w->getNode2();
                        goto Correct;
                    }

                    break;
                default:
                    break;
                }
            }
        }
Correct:
        if(checkNode1 != -1)
        {
            if(voltageAtNode(checkNode1) == std::max(voltageAtNode(r->getNode1()), voltageAtNode(r->getNode2())) || voltageAtNode(checkNode2) == std::max(voltageAtNode(r->getNode1()), voltageAtNode(r->getNode2())) ){
                switch (angle) {
                case 1:
                    r->setAngle(3);
                    r->setXCoord(r->getXCoord() + 1);
                    break;
                case 2:
                    r->setAngle(4);
                    r->setYCoord(r->getYCoord() + 1);
                    break;
                case 3:
                    r->setAngle(1);
                    r->setXCoord(r->getXCoord() - 1);
                    break;
                case 4 :
                    r->setAngle(2);
                    r->setYCoord(r->getYCoord() - 1);
                    break;

                }
            }

        }

    }
}


/* method sets the current in all the resistors and switches,
 * method provided by the other team */
void Calc::setCurrentsOfResistorsAndSwitches()
{
    for(auto& r : resistors){
        r->setCurrent(std::abs(voltageAtNode(r->getNode1())-voltageAtNode(r->getNode2()))/r->getValue());
    }
    for(auto& sw : switches){
        if(!sw->getUp())
            sw->setCurrent(std::abs(voltageAtNode(sw->getNode1())-voltageAtNode(sw->getNode2()))/sw->getValue());
        else
            sw->setCurrent(0);
    }
}
/* method sets the current in all the wires,
 * method provided by the other team */
void Calc::setCurrentsOfWires()
{
    //Joined vector with resistors,switches and sources
    std::vector<std::shared_ptr<Component>> comps;
    comps.insert(comps.end(), resistors.begin(), resistors.end());
    comps.insert(comps.end(), switches.begin(), switches.end());
    comps.insert(comps.end(), sources.begin(),sources.end());

    //For every component, calculate current trough neighbours
    for(auto& c : comps){

        int nodemin,nodemax;
        QPoint pos(c->getXCoord(),c->getYCoord());
        std::shared_ptr<Wire> wTemp;
        std::shared_ptr<Wire> lastWire;
        int connectedWires = 0;
        bool cross = false;
        int node;
        int corFactor = 1;

        //Pointer used for checking if component is a source. Becauce sources behave a bit different
        std::shared_ptr<Source> s = std::dynamic_pointer_cast<Source>(c);

        //Calculate max and min node
        if (s.get()==nullptr)
        {
            if( std::max(voltageAtNode(c->getNode1()), voltageAtNode(c->getNode2())) == voltageAtNode(c->getNode1()))
            {
                nodemax = c->getNode1();
                nodemin = c->getNode2();
            }
            else{
                nodemax = c->getNode2();
                nodemin = c->getNode1();
            }
        }
        else
        {
            nodemax = c->getNodep();
            nodemin = c->getNodem();
        }

        /*Go trough the loop twice, once for maxNode, once for minNode*/
        for(int i = 0; i<2;i++){
            switch(i){
            case 0:
                node = nodemin;
                break;
            case 1:
                node = nodemax;
                corFactor *= -1;
                break;
            }

            /*Connect connected elements, then assign currents*/
            while(!cross)
            {
                for(auto& w : wires)
                {
                    if(w->getNode() == node)
                    {
                        if(w!=lastWire)
                        {
                            int xp = w->getXCoord();
                            int yp = w->getYCoord();
                            int l = w->getLength();
                            switch (w->getAngle())
                            {
                            case 1:
                                if(pos==QPoint(xp,yp) || pos == QPoint(xp+l,yp))
                                {
                                    connectedWires++;
                                    wTemp = w;
                                }
                                break;
                            case 2:
                                if(pos==QPoint(xp,yp) || pos== QPoint(xp,yp+l))
                                {
                                    connectedWires++;
                                    wTemp = w;
                                }
                                break;
                            case 3:
                                if(pos == QPoint(xp,yp) ||pos == QPoint(xp-l,yp))
                                {
                                    connectedWires++;
                                    wTemp = w;
                                }
                                break;
                            case 4:
                                if(pos==QPoint(xp,yp) || pos == QPoint(xp,yp-l))
                                {
                                    connectedWires++;
                                    wTemp = w;
                                }
                                break;
                            default:
                                break;
                            }
                        }
                    }
                }

                for(auto& co:comps){
                    if(co!=c){
                        if(std::dynamic_pointer_cast<Source>(co)!=nullptr)
                        {
                            if(pos == QPoint(co->getXCoord(),co->getYCoord()))
                                connectedWires+=2;
                        }
                        else if(co->getNode1()==node || co->getNode2()==node)
                        {
                            int xp = co->getXCoord();
                            int yp = co->getYCoord();
                            switch(co->getAngle()){

                            case 1:
                                if(pos==QPoint(xp,yp) || pos == QPoint(xp+1,yp))
                                {
                                    connectedWires+=2;
                                }
                                break;
                            case 2:
                                if(pos==QPoint(xp,yp) || pos== QPoint(xp,yp+1))
                                {
                                    connectedWires+=2;
                                }
                                break;
                            case 3:
                                if(pos == QPoint(xp,yp) ||pos == QPoint(xp-1,yp))
                                {
                                    connectedWires+=2;
                                }
                                break;
                            case 4:
                                if(pos==QPoint(xp,yp) || pos == QPoint(xp,yp-1))
                                {
                                    connectedWires+=2;
                                }
                                break;
                            default:
                                break;
                            }
                        }
                    }
                }

                /*Check nr of connections, if only one: assign current, and jump to the end of the wire
                 *else stop calculations for this node*/
                if(connectedWires ==1)
                {
                    wTemp->setCurrent(c->getCurrent()*corFactor);
                    switch(wTemp->getAngle()){
                    case 1:
                        if(wTemp->getXCoord()==pos.x())
                            pos.setX(pos.x()+wTemp->getLength());
                        else{
                            pos.setX(pos.x()-wTemp->getLength());
                            wTemp->setCurrent(wTemp->getCurrent()*-1);
                        }
                        break;
                    case 2:
                        if(wTemp->getYCoord()==pos.y())
                            pos.setY(pos.y()+wTemp->getLength());
                        else{
                            pos.setY(+pos.y()-wTemp->getLength());
                            wTemp->setCurrent(wTemp->getCurrent()*-1);
                        }
                        break;
                    case 3:
                        if(wTemp->getXCoord()==pos.x())
                            pos.setX(pos.x()-wTemp->getLength());
                        else{
                            pos.setX(pos.x()+wTemp->getLength());
                            wTemp->setCurrent(wTemp->getCurrent()*-1);
                        }
                        break;
                    case 4:
                        if(wTemp->getYCoord()==pos.y())
                            pos.setY(pos.y()-wTemp->getLength());
                        else{
                            pos.setY(pos.y()+wTemp->getLength());
                            wTemp->setCurrent(wTemp->getCurrent()*-1);
                        }
                        break;
                    }
                    lastWire = wTemp;
                    connectedWires = 0;
                }
                else{
                    cross = true;
                }
            }


            /*Re-adjust parameters for second loop*/
            cross = false;
            connectedWires = 0;
            lastWire = nullptr;
            if(s.get()==nullptr)
            {
                int angle= c->getAngle();
                switch(angle)
                {
                case 1:
                    pos.setX(c->getXCoord()+1);
                    pos.setY(c->getYCoord());
                    break;
                case 2:
                    pos.setX(c->getXCoord());
                    pos.setY(c->getYCoord()+1);
                    break;
                case 3:
                    pos.setX(c->getXCoord()-1);
                    pos.setY(c->getYCoord());
                    break;
                case 4:
                    pos.setX(c->getXCoord());
                    pos.setY(c->getYCoord()-1);
                    break;
                }
            }
            else{
                pos.setX(c->getXCoord());
                pos.setY(c->getYCoord());
            }
        }
    }
}
/* method sets the current in all the stray wires,
 * method provided by the other team */
bool Calc::setCurrentsOfStrayWires(){

    int timeout;
    std::vector<std::shared_ptr<Wire>> strayWires;
    std::vector<std::shared_ptr<Wire>> toRemove;

    /*Check for wires wich haven't got a real current value and put them in a temp vector*/
    for(auto& wi:wires){
        if(std::isinf(wi->getCurrent())){
            strayWires.push_back(wi);
        }
    }

    std::vector<std::shared_ptr<Component>> toCheck;
    toCheck.insert(toCheck.end(), wires.begin(),wires.end());
    toCheck.insert(toCheck.end(), resistors.begin(), resistors.end());
    toCheck.insert(toCheck.end(), switches.begin(), switches.end());

    /*As long as there are stray wires, stay in loop*/
    while(!(strayWires.empty())){
        timeout++;
        for(auto& w:strayWires){

            QPoint pos(w->getXCoord(),w->getYCoord());
            int corr = -1;
            if(timeout%2 ==0){
                corr = 1;
                switch(w->getAngle()){
                case 1:
                    pos.setX(pos.x()+1);
                    break;
                case 2:
                    pos.setY(pos.y()+1);
                    break;
                case 3:
                    pos.setX(pos.x()+1);

                    break;
                case 4:
                    pos.setY(pos.y()-1);
                    break;
                default:
                    break;

                }
            }
            float curr = 0;
            //Sum up the currents of al neighbouring wires
            for (auto wire:toCheck){
                if(wire!=w){
                    int xp = wire->getXCoord();
                    int yp = wire->getYCoord();
                    int l = wire->getLength();

                    float current = wire->getCurrent();
                    if(std::dynamic_pointer_cast<Resistor>(wire)){
                        current=current*-1;
                    }
                    switch (wire->getAngle()) {

                    case 1:
                        if(pos==QPoint(xp,yp) ){
                            curr += current;
                        }
                        else if(pos == QPoint(xp+l,yp)){
                            curr -= current;
                        }
                        break;
                    case 2:
                        if(pos==QPoint(xp,yp)){
                            curr += current;
                        }
                        else if (pos== QPoint(xp,yp+l)){
                            curr -= current;
                        }
                        break;
                    case 3:
                        if(pos==QPoint(xp,yp)){
                            curr += current;
                        }
                        else if ( pos== QPoint(xp-l,yp)){
                            curr -= current;
                        }
                        break;
                    case 4:
                        if(pos==QPoint(xp,yp)){
                            curr += current;
                        }
                        else if ( pos== QPoint(xp,yp-l)){
                            curr -= current;
                        }
                        break;
                    default:
                        break;
                    }
                }
            }
            w->setCurrent(corr*curr);

            //If current is real, push to toRemove
            if(!(std::isinf(w->getCurrent())))
                toRemove.push_back(w);
        }
        /*Remove toRemove from staywires*/
        for(auto& r:toRemove){
            strayWires.erase( std::remove( strayWires.begin(), strayWires.end(), r), strayWires.end() );
        }
        /*If loop is stuck, return false (worst case scenario)*/
        if(timeout>50)
            return false;
    }
    return true;
}



/* computes the voltages in all the nodes,
 * method provided by the other team */
std::vector<float> Calc::computeNetwork(int  nrOfNodes)
{
    //Compute voltages for each node, done by matrix calculations. See report for more details

    const int m =sources.size();
    MatrixXf a((nrOfNodes+m),(nrOfNodes+m)); //Matrix with all parameters

    MatrixXf g(nrOfNodes,nrOfNodes); //Part of A Matrix, describes all connected passive elements
    MatrixXf b(nrOfNodes,m);    //Part of A Matrix, describes connections of all sources
    MatrixXf c(m,nrOfNodes);    //Part of A Matrix, transpose of B
    MatrixXf d(m,m);          //All zeros, can be used for dependant sources

    MatrixXf z(nrOfNodes+m,1); // Holds values of independant current and voltage sources
    MatrixXf i(nrOfNodes,1);   //Part of Z matrix, holds values of current sources
    MatrixXf e(m,1); //Part of Z matrix, holds values of voltage sources

    VectorXf x; //Hold unknowm quantities. Voltages at nodes and currents trough source

    //initialize matrices
    g<<MatrixXf::Zero(nrOfNodes,nrOfNodes);
    b<<MatrixXf::Zero(nrOfNodes,m);
    c<<MatrixXf::Zero(m,nrOfNodes);
    d<<MatrixXf::Zero(m,m);
    a<<MatrixXf::Zero(nrOfNodes+m,nrOfNodes+m);
    z<<MatrixXf::Zero(nrOfNodes+m,1);
    i<<MatrixXf::Zero(nrOfNodes,1);
    e<<MatrixXf::Zero(m,1);


    //Joined vector with resistors and switches
    std::vector<std::shared_ptr<Component>> swAndR;
    swAndR.insert( swAndR.end(), resistors.begin(), resistors.end());
    swAndR.insert( swAndR.end(), switches.begin(), switches.end());

    //Fill matrix for g with Resistors and switches
    for(auto& res:swAndR){

        for (int i=1;i<=nrOfNodes;i++){
            if(res->getNode1()==i||res->getNode2()==i){
                g(i-1,i-1)+=(1/(res->getValue()));
            }
        }
        if(res->getNode1()!=0&&res->getNode2()!=0){
            g(res->getNode1()-1,res->getNode2()-1)+= (-1/res->getValue());
            g(res->getNode2()-1,res->getNode1()-1)+= (-1/res->getValue());
        }

    }

    //Fill matrix b
    for(int i=0;i<m;i++){
        for (int j=1;j<=nrOfNodes;j++){
            if(sources.at(i)->getNodep()==j){
                b(j-1,i)=1;
            }
            if(sources.at(i)->getNodem()==j){
                b(j-1,i)=-1;
            }

        }
    }

    //Fill matrix c
    for(int i=0;i<m;i++){
        for (int j=1;j<=nrOfNodes;j++){
            if(sources.at(i)->getNodep()==j){
                c(i,j-1)=1;
            }
            if(sources.at(i)->getNodem()==j){
                c(i,j-1)=-1;
            }
        }
    }

    //Build A Matrix
    a.resize(g.rows()+c.rows(),b.cols()+g.cols());
    a<<g,b,
            c,d ;




    //Fill e matrix
    for(int i=0;i<m;i++){
        e(i,0)=sources.at(i)->getValue();
    }

    //Build z Matrix
    z<<i,
            e;

    //Solve for X
    x = a.colPivHouseholderQr().solve(z);


    //Save solutions
    std::vector<float> solu;
    solu.push_back(0);   //Add value of ground node, always 0
    for (int i=0;i<nrOfNodes-1;i++){
        solu.push_back(x(i));
    }

    for (int i = 0; i< m;i++){
        sources.at(i)->setCurrent(x(i+nrOfNodes));
    }


    return solu;




}
/* method gets the size of the screen */
int Calc::getPhysicalScreenWidth()
{
    foreach (QScreen *screen, QGuiApplication::screens()) {
        return screen->physicalSize().width();
    }
    return 0;
}
/* method that returns screen orientation */
QString Orientation(Qt::ScreenOrientation orientation)
{
    switch (orientation) {
    case Qt::PrimaryOrientation           : return "Primary";
    case Qt::LandscapeOrientation         : return "Landscape";
    case Qt::PortraitOrientation          : return "Portrait";
    case Qt::InvertedLandscapeOrientation : return "Inverted landscape";
    case Qt::InvertedPortraitOrientation  : return "Inverted portrait";
    default                               : return "Unknown";
    }

}
/* print info */
void Calc::printScreenInfo()
{
    qDebug() << "Number of screens:" << QGuiApplication::screens().size();

    qDebug() << "Primary screen:" << QGuiApplication::primaryScreen()->name();

    foreach (QScreen *screen, QGuiApplication::screens()) {
        qDebug() << "Information for screen:" << screen->name();
        qDebug() << "  Available geometry:" << screen->availableGeometry().x() << screen->availableGeometry().y() << screen->availableGeometry().width() << "x" << screen->availableGeometry().height();
        qDebug() << "  Available size:" << screen->availableSize().width() << "x" << screen->availableSize().height();
        qDebug() << "  Available virtual geometry:" << screen->availableVirtualGeometry().x() << screen->availableVirtualGeometry().y() << screen->availableVirtualGeometry().width() << "x" << screen->availableVirtualGeometry().height();
        qDebug() << "  Available virtual size:" << screen->availableVirtualSize().width() << "x" << screen->availableVirtualSize().height();
        qDebug() << "  Depth:" << screen->depth() << "bits";
        qDebug() << "  Geometry:" << screen->geometry().x() << screen->geometry().y() << screen->geometry().width() << "x" << screen->geometry().height();
        qDebug() << "  Logical DPI:" << screen->logicalDotsPerInch();
        qDebug() << "  Logical DPI X:" << screen->logicalDotsPerInchX();
        qDebug() << "  Logical DPI Y:" << screen->logicalDotsPerInchY();
        qDebug() << "  Orientation:" << Orientation(screen->orientation());
        qDebug() << "  Physical DPI:" << screen->physicalDotsPerInch();
        qDebug() << "  Physical DPI X:" << screen->physicalDotsPerInchX();
        qDebug() << "  Physical DPI Y:" << screen->physicalDotsPerInchY();
        qDebug() << "  Physical size:" << screen->physicalSize().width() << "x" << screen->physicalSize().height() << "mm";
        qDebug() << "  Primary orientation:" << Orientation(screen->primaryOrientation());
        qDebug() << "  Refresh rate:" << screen->refreshRate() << "Hz";
        qDebug() << "  Size:" << screen->size().width() << "x" << screen->size().height();
        qDebug() << "  Virtual geometry:" << screen->virtualGeometry().x() << screen->virtualGeometry().y() << screen->virtualGeometry().width() << "x" << screen->virtualGeometry().height();
        qDebug() << "  Virtual size:" << screen->virtualSize().width() << "x" << screen->virtualSize().height();
    }
}

int Calc::getTwoStar() const
{
    return twoStar;
}

int Calc::getThreeStar() const
{
    return threeStar;
}





