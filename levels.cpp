#include "levels.h"


using namespace std;

Levels::Levels(QObject *parent) : QObject(parent)
{
    tester = 5;
}

void Levels::readLevels()
{

    qDebug() << "begin of readLevels";
    string line;

    ifstream myfile ("C:/Users/anton.DESKTOP-FMBU6U7/Documents/GitHub/QT3D/levels.txt");
    if(myfile.is_open())
    {
        while(getline(myfile,line))
        {
            tester = 10;
            qDebug() << QString::fromStdString(line);
        }
    }
    else{
        tester = 15;
        qDebug() << "Unable to open file";
    }
}

int Levels::getTester() const
{
    return tester;
}

void Levels::setTester(int value)
{
    tester = value;
}
