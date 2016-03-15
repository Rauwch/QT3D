#include "calc.h"
#include <iostream>
#include <vector>
#include <QTextStream>
#include <QPoint>
#include "Eigen/Dense"
#include <QStandardPaths>


using namespace Eigen;
Calc::Calc()
{

}

void Calc::solveLevel()
{
    std::list<int> nodes;

    for(auto v:sources){
        nodes.push_back(v->getNodem());
        nodes.push_back(v->getNodep());
    }
    for(auto r:resistors){

        nodes.push_back(r->getNode1());
        nodes.push_back(r->getNode2());
    }

    nodes.sort();
    nodes.unique();
    sol=computeNetwork(nodes.size());
    //functie om sources, wires en resistors opnieuw te vullen
    correctAngles();
    setCurrentsOfResistors();

    for(auto w:wires){
        w->setCurrent(std::numeric_limits<float>::infinity());
    }

    setCurrentsOfWires();
    qDebug() << "END OF SOLVE LEVEL";
}

void Calc::storeCurrentGoals()
{
    for(unsigned int i = 0; i < wires.size(); i++)
    {
        if(wires.at(i)->getIsGoal())
        {
            currentGoals.push_back(wires.at(i));
            wires.at(i)->setGoalValue(wires.at(i)->getCurrent());
            qDebug() << "this is the starting current: " << wires.at(i)->getCurrent();
        }

    }
    qDebug() << "this is the amount of current Goals " << currentGoals.size();
}




void Calc::readFile(QString s)
{

    //TODO Checken of een file volledig juist is
    fileName = s;
    QFile * file = new QFile(s);
    if (file->open(QIODevice::ReadOnly| QIODevice::Text))
    {
        QTextStream in(file);
        while (!in.atEnd())
        {
            QString line = in.readLine();
            if (!line.isEmpty()&&!line.isNull()){

                switch (line.at(0).toLower().toLatin1()) //to check first character
                {
                case '*':
                    if(line.length()>=2 ){

                        switch(line.at(1).toLower().toLatin1()){

                        case's':
                            for (int i=2;i<line.length();i++){
                                if(line.at(i).toLower().toLatin1()=='j'){ //TODO check if index is too big necessary?
                                    qDebug()<<"start of file, found correct sj start";
                                }
                            }
                            break;

                        case 'g':
                            process_goal_line(line);

                            break;

                        case 'w':
                            if(line.length()>2){

                                auto wir=process_wire_line(line);
                                wires.insert(std::end(wires), std::begin(wir), std::end(wir));
                            }
                            break;

                        case 'c':
                            process_click_line(line);
                            break;
                        case '/':
                            if(line.length()>2){
                                //qDebug()<<line;
                                //#ingnore
                            }

                            break;

                        default:
                            break;
                        }
                    }
                    break;


                case '\n':
                    //just continue
                    //qDebug()<<"read a newline char"<<"\n ";
                    break;

                case ' ':
                    //just continue
                    // qDebug()<<"read a space"<<"\n ";
                    break;

                case 'r':
                    //do for resistor
                    process_resistor_line(line);
                    break;

                case 'v':
                    //do for source
                    process_source_line(line);
                    break;

                case '.':
                    // do for end
                    break;

                default :
                    qDebug()<<"something went wrong" <<"\n";
                    break;
                }
            }


        }
        file->close();
    }
}

void Calc::updateSources()
{
    for(unsigned int i= 0; i < sources.size(); i++)
    {
        qDebug() <<"sourcers ervoor " << sources.at(i)->getValue();
        if(sources.at(i)->getInitialValue() != 0)
        {
            sources.at(i)->setValue(sources.at(i)->getInitialValue());
            qDebug() <<"sourcers erna " <<sources.at(i)->getValue();

        }
    }
}

void Calc::updateResistors()
{

    for( unsigned int i= 0; i < resistors.size(); i++)
    {
        qDebug() << "resistors ervoor "<< resistors.at(i)->getValue();
        if(resistors.at(i)->getInitialValue() != 0)
        {
            resistors.at(i)->setValue(resistors.at(i)->getInitialValue());
            qDebug() << "resistors erna "<< resistors.at(i)->getValue();
        }
    }

}


//Read lines of when a component is declared

std::vector<std::shared_ptr<Wire> > Calc::process_wire_line(QString &lijn)
{
    std::vector<std::shared_ptr<Wire>> wir;
    lijn.replace("*","",Qt::CaseSensitivity::CaseInsensitive); //remove *
    lijn.replace("w","",Qt::CaseSensitivity::CaseInsensitive); //remove w

    QStringList list=lijn.split(",");
    for (QStringList::iterator it = list.begin(); it != list.end(); ++it) {
        QString current = *it;
        QStringList wireParams=current.split(" ",QString::SkipEmptyParts);
        int x=wireParams.at(1).toInt();
        int y=wireParams.at(2).toInt();
        int angle=wireParams.at(0).toInt();
        int length=wireParams.at(4).toInt();
        bool isGoal;
        if(wireParams.at(5).toInt() == 1)
        {
            isGoal = true;
        }
        else if(wireParams.at(5).toInt() == 0)
        {
            isGoal = false;
        }
        else
        {
            qDebug() << "Wrong entry for variable";
        }
        int node=wireParams.at(3).toInt();
        auto w =std::make_shared<Wire>(x,y,angle,length,node,isGoal);
        wir.push_back(w);
        //TODO check if input is correct!!

    }

    return wir;
}

void Calc::process_resistor_line(QString &lijn)
{

    lijn.replace("r","",Qt::CaseSensitivity::CaseInsensitive); //remove r
    QStringList list=lijn.split(" ",QString::SkipEmptyParts);

    int x=list.at(5).toInt();
    int y=list.at(6).toInt();
    int angle=list.at(7).toInt();
    bool variable;
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
    int initial = list.at(9).toInt();
    int step = list.at(10).toInt();
    int node1=list.at(1).toInt();
    int node2=list.at(2).toInt();
    float v=list.at(3).toFloat();
    auto r =std::make_shared<Resistor>(v,node1,node2,x,y,angle,variable,initial,step);
    resistors.push_back(r);

}



void Calc::process_source_line(QString &lijn)
{

    lijn.replace("v","",Qt::CaseSensitivity::CaseInsensitive); //remove v
    QStringList list=lijn.split(" ",QString::SkipEmptyParts);
    qDebug() << list;
    int x=list.at(5).toInt();
    int y=list.at(6).toInt();
    int angle=list.at(7).toInt();
    bool variable;
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
    int initial = list.at(9).toInt();
    qDebug() << "this is the initiale " << initial;

    int step = list.at(10).toInt();
    qDebug() << "this is the step size " << step;
    int nodep=list.at(1).toInt();
    int nodem=list.at(2).toInt();
    float v=list.at(3).toFloat();
    auto s =std::make_shared<Source>(v,nodep,nodem,x,y,angle,step, variable,initial);
    qDebug() << "ADDED a SOURCE TO THE SOURCE LIST";
    sources.push_back(s);


}

void Calc::process_goal_line(QString &lijn)
{
    qDebug() << "reading a new goal line" ;
    lijn.replace("*","",Qt::CaseSensitivity::CaseInsensitive); //remove *
    lijn.replace("g","",Qt::CaseSensitivity::CaseInsensitive); //remove g
    QStringList list=lijn.split(" ");


    int x = list.at(0).toInt();
    int y = list.at(1).toInt();
    int node = list.at(2).toInt();
    auto g = std::make_shared<GoalVoltage>(x,y,node);
    goals.push_back(g);

}

void Calc::process_click_line(QString &lijn)
{
    qDebug() << "reading a new click line" ;
    lijn.replace("*","",Qt::CaseSensitivity::CaseInsensitive); //remove *
    lijn.replace("c","",Qt::CaseSensitivity::CaseInsensitive); //remove c
    QStringList list=lijn.split(" ");

    twoStar = list.at(0).toInt();
    threeStar = list.at(1).toInt();
}
// Comparing ints to round of the floats
bool Calc::checkGoals()
{

    bool allGoals = true;
    int goalVoltage;
    int goalNode;
    int currentVoltage;

    for(unsigned int i = 0; i < goals.size();i++)
    {

        goalVoltage = goals.at(i)->getVoltage();
        goalNode = goals.at(i)->getNode();
        currentVoltage = voltageAtNode(goalNode);
        qDebug()  <<"this is the current voltage: " << currentVoltage << " and the goalVoltage: " << goalVoltage;
        if(goalVoltage != currentVoltage)
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

    for(unsigned int i = 0; i <currentGoals.size();i++)
    {
        qDebug() << "currentCurrent is: " <<(float) currentGoals.at(i)->getCurrent() << "  goalCurrent is:  " << (float) currentGoals.at(i)->getGoalValue() ;
        if(currentGoals.at(i)->getCurrent()!= currentGoals.at(i)->getGoalValue())
        {
            allGoals = false;
            currentGoals.at(i)->setMatch(false);
        }
        else
        {
            currentGoals.at(i)->setMatch(true);
        }
    }

    if(allGoals)
    {

    }

    return allGoals;
}

int Calc::calculateAngle()
{
    float Igoal = getCurrentInGoalWire();
    float Icurrent = getGoalinGoalWire();
    int angle;
    angle = (Igoal-Icurrent)/(Igoal)+90;
    return angle;
}

int Calc::getTwoStar() const
{
    return twoStar;
}

int Calc::getThreeStar() const
{
    return threeStar;
}


//Functie om hoek te corrigeren TODO proberen verkleinen
void Calc::correctAngles()
{
    for(auto r:resistors){
        QPoint p(r->getXCoord(),r->getYCoord());
        int angle = r->getAngle();
        int node = -1;

        switch (angle) {

        case 1:

            for(auto w:wires){
                int xp = w->getXCoord();
                int yp = w->getYCoord();
                int l = w->getLength();
                switch (w->getAngle()) {
                case 1:
                    if(p == QPoint(xp+l,yp)){
                        node = w->getNode();
                        goto Correct1;
                    }

                    break;
                case 2:
                    if(p==QPoint(xp,yp) || p == QPoint(xp,yp+l)){
                        node = w->getNode();
                        goto Correct1;
                    }

                    break;
                case 3:
                    if(p == QPoint(xp,yp)){
                        node = w->getNode();
                        goto Correct1;
                    }

                    break;
                case 4:
                    if(p==QPoint(xp,yp) || p == QPoint(xp,yp-l)){
                        node = w->getNode();
                        goto Correct1;
                    }

                    break;
                default:
                    break;
                }
            }
Correct1:
            if(node != -1)
            {
                if(voltageAtNode(node) == std::max(voltageAtNode(r->getNode1()), voltageAtNode(r->getNode2()))){
                    r->setAngle(3);
                    r->setXCoord(r->getXCoord() + 1);

                }

            }
            break;


        case 2:

            for(auto w:wires){
                int xp = w->getXCoord();
                int yp = w->getYCoord();
                int l = w->getLength();
                switch (w->getAngle()) {
                case 1:
                    if(p==QPoint(xp,yp) || p == QPoint(xp+l,yp)){
                        node = w->getNode();
                        goto Correct2;
                    }

                    break;
                case 2:
                    if(p == QPoint(xp,yp+l)){
                        node = w->getNode();
                        goto Correct2;
                    }

                    break;
                case 3:
                    if(p==QPoint(xp,yp) || p == QPoint(xp-l,yp)){
                        node = w->getNode();
                        goto Correct2;
                    }

                    break;
                case 4:
                    if(p == QPoint(xp,yp)){
                        node = w->getNode();
                        goto Correct2;
                    }

                    break;
                default:
                    break;
                }
            }
Correct2:
            if(node != -1)
            {
                if(voltageAtNode(node) == std::max(voltageAtNode(r->getNode1()), voltageAtNode(r->getNode2()))){
                    r->setAngle(4);
                    r->setYCoord(r->getYCoord() + 1);

                }

            }
            break;
        case 3:
            for(auto w:wires){
                int xp = w->getXCoord();
                int yp = w->getYCoord();
                int l = w->getLength();
                switch (w->getAngle()) {
                case 1:
                    if(p == QPoint(xp,yp)){
                        node = w->getNode();
                        goto Correct3;
                    }

                    break;
                case 2:
                    if(p==QPoint(xp,yp) || p == QPoint(xp,yp+l)){
                        node = w->getNode();
                        goto Correct3;
                    }

                    break;
                case 3:
                    if(p == QPoint(xp-l,yp)){
                        node = w->getNode();
                        goto Correct3;
                    }

                    break;
                case 4:
                    if(p==QPoint(xp,yp) || p == QPoint(xp,yp-l)){
                        node = w->getNode();
                        goto Correct3;
                    }

                    break;
                default:
                    break;
                }
            }
Correct3:
            if(node != -1)
            {
                if(voltageAtNode(node) == std::max(voltageAtNode(r->getNode1()), voltageAtNode(r->getNode2()))){
                    r->setAngle(1);
                    r->setXCoord(r->getXCoord() - 1);

                }

            }
            break;
        case 4:
            for(auto w:wires){
                int xp = w->getXCoord();
                int yp = w->getYCoord();
                int l = w->getLength();
                switch (w->getAngle()) {
                case 1:
                    if(p==QPoint(xp,yp) || p == QPoint(xp+l,yp)){
                        node = w->getNode();
                        goto Correct4;
                    }

                    break;
                case 2:
                    if(p == QPoint(xp,yp)){
                        node = w->getNode();
                        goto Correct4;
                    }

                    break;
                case 3:
                    if(p==QPoint(xp,yp) || p == QPoint(xp-l,yp)){
                        node = w->getNode();
                        goto Correct4;
                    }

                    break;
                case 4:
                    if(p == QPoint(xp,yp-l)){
                        node = w->getNode();
                        goto Correct4;
                    }

                    break;
                default:
                    break;
                }
            }
Correct4:
            if(node != -1)
            {
                if(voltageAtNode(node) == std::max(voltageAtNode(r->getNode1()), voltageAtNode(r->getNode2()))){
                    r->setAngle(2);
                    r->setYCoord(r->getYCoord() - 1);

                }

            }
            break;
        default:
            break;
        }
    }
}

void Calc::setCurrentsOfResistors()
{
    for(auto r : resistors){
        r->setCurrent(std::abs(voltageAtNode(r->getNode1())-voltageAtNode(r->getNode2()))/r->getValue());
    }

}

void Calc::setCurrentsOfWires()
{

    for(auto r : resistors){

        int nodemin,nodemax;
        if( std::max(voltageAtNode(r->getNode1()), voltageAtNode(r->getNode2())) == voltageAtNode(r->getNode1())){
            nodemax = r->getNode1();
            nodemin = r->getNode2();
        }
        else{
            nodemax = r->getNode2();
            nodemin = r->getNode1();
        }

        QPoint pos(r->getXCoord(),r->getYCoord());
        std::shared_ptr<Wire> wTemp;
        std::shared_ptr<Wire> lastWire;
        int connectedWires = 0;
        bool cross = false;
        int node;
        int corFactor = 1;

        //Ga tweemaal door loop, een keer voor maxNode eenmaal voor minNode.
        for(int i = 0; i<2;i++){
            switch(i){
            case 0:
                node = nodemin;
                break;

            case 1:
                node = nodemax;
                corFactor = -1;
                break;

            }

            //Check connected elements, if only one connected: assign same current to wire)
            while(!cross){
                for(auto w : wires){
                    if(w->getNode() == node){
                        if(w!=lastWire){

                            int xp = w->getXCoord();
                            int yp = w->getYCoord();
                            int l = w->getLength();
                            switch (w->getAngle()) {

                            case 1:
                                if(pos==QPoint(xp,yp) || pos == QPoint(xp+l,yp)){
                                    connectedWires++;
                                    wTemp = w;
                                }

                                break;
                            case 2:
                                if(pos==QPoint(xp,yp) || pos== QPoint(xp,yp+l)){
                                    connectedWires++;
                                    wTemp = w;
                                }


                                break;
                            case 3:
                                if(pos == QPoint(xp,yp) ||pos == QPoint(xp-l,yp)){
                                    connectedWires++;
                                    wTemp = w;
                                }


                                break;
                            case 4:
                                if(pos==QPoint(xp,yp) || pos == QPoint(xp,yp-l)){
                                    connectedWires++;
                                    wTemp = w;
                                }

                                break;
                            default:
                                break;
                                //TODO catch default
                            }
                        }
                    }
                }
                for(auto s:sources){
                    if(pos == QPoint(s->getXCoord(),s->getYCoord()))
                        connectedWires+=2;
                }
                for(auto res:resistors){

                    if(res!=r){
                        if(res->getNode1()==node || res->getNode2()==node){
                            int xp = res->getXCoord();
                            int yp = res->getYCoord();
                            switch(res->getAngle()){

                            case 1:
                                if(pos==QPoint(xp,yp) || pos == QPoint(xp+1,yp)){
                                    connectedWires+=2;
                                }

                                break;
                            case 2:
                                if(pos==QPoint(xp,yp) || pos== QPoint(xp,yp+1)){
                                    connectedWires+=2;
                                }


                                break;
                            case 3:
                                if(pos == QPoint(xp,yp) ||pos == QPoint(xp-1,yp)){
                                    connectedWires+=2;
                                }


                                break;
                            case 4:
                                if(pos==QPoint(xp,yp) || pos == QPoint(xp,yp-1)){
                                    connectedWires+=2;
                                }

                                break;
                            default:
                                break;

                            }
                        }
                    }
                }
                if(connectedWires ==1){
                    wTemp->setCurrent(r->getCurrent()*corFactor);
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
            cross = false;
            connectedWires = 0;
            lastWire = nullptr;
            int angle= r->getAngle();
            switch(angle){
            case 1:
                pos.setX(r->getXCoord()+1);
                pos.setY(r->getYCoord());
                break;
            case 2:
                pos.setX(r->getXCoord());
                pos.setY(r->getYCoord()+1);
                break;
            case 3:
                pos.setX(r->getXCoord()-1);
                pos.setY(r->getYCoord());
                break;
            case 4:
                pos.setX(r->getXCoord());
                pos.setY(r->getYCoord()-1);
                break;

            }
        }
    }


    //Draden die niet aan weerstand liggen

    //Zolang er er nog een weerstand met oneindigestromen is, in while blijven
    bool inf = true;
    while(inf){

        inf = false;

        //Check alle draden waar nog geen stroom aan toegekend is
        for(auto w:wires){
            if(std::isinf(w->getCurrent())){
                QPoint pos(w->getXCoord(),w->getYCoord());
                float curr = 0;

                //Tel de stromen op van alle andere verbonde draden
                for (auto wire:wires){
                    if(wire!=w){
                        int xp = wire->getXCoord();
                        int yp = wire->getYCoord();
                        int l = wire->getLength();
                        switch (wire->getAngle()) {

                        case 1:
                            if(pos==QPoint(xp,yp) || pos == QPoint(xp+l,yp)){
                                curr += wire->getCurrent();
                            }

                            break;
                        case 2:
                            if(pos==QPoint(xp,yp) || pos== QPoint(xp,yp+l)){
                                curr += wire->getCurrent();
                            }

                            break;
                        case 3:
                            if(pos == QPoint(xp,yp) ||pos == QPoint(xp-l,yp)){
                                curr += wire->getCurrent();
                            }


                            break;
                        case 4:
                            if(pos==QPoint(xp,yp) || pos == QPoint(xp,yp-l)){
                                curr += wire->getCurrent();
                            }

                            break;
                        default:
                            break;
                        }


                    }
                }
                w->setCurrent(curr);
                if(std::isinf(w->getCurrent()))
                    inf=true; //Blijf in lus

            }
        }
    }

}




std::vector<float> Calc::computeNetwork(int  nrOfNodes)
{
    //m is nrOfSources
    const int m =sources.size();
    MatrixXf g(nrOfNodes,nrOfNodes);
    MatrixXf b(nrOfNodes,m);
    MatrixXf c(m,nrOfNodes);
    MatrixXf d(m,m);          //dependant sources
    MatrixXf a((nrOfNodes+m),(nrOfNodes+m));

    MatrixXf z(nrOfNodes+m,1);
    MatrixXf i(nrOfNodes,1);
    MatrixXf e(m,1);

    //init matrices
    g<<MatrixXf::Zero(nrOfNodes,nrOfNodes);
    b<<MatrixXf::Zero(nrOfNodes,m);
    c<<MatrixXf::Zero(m,nrOfNodes);
    d<<MatrixXf::Zero(m,m);
    a<<MatrixXf::Zero(nrOfNodes+m,nrOfNodes+m);
    z<<MatrixXf::Zero(nrOfNodes+m,1);
    i<<MatrixXf::Zero(nrOfNodes,1);
    e<<MatrixXf::Zero(m,1);
    //Fill matrix for G

    // TODO make list of nodes and loop trough
    for(auto res:resistors){

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

    a.resize(g.rows()+c.rows(),b.cols()+g.cols());
    a<<g,b,
            c,d       ;




    //fill e matrix
    for(int i=0;i<m;i++){
        e(i,0)=sources.at(i)->getValue();
    }


    z<<i,
            e;

    VectorXf x = a.colPivHouseholderQr().solve(z);

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




