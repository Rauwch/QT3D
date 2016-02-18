#include "levels.h"




Levels::Levels(QObject *parent) : QObject(parent)
{
   getLevelAmount();
   printArray();

}



void Levels::getLevelAmount()
{
    string path = QDir::homePath().toStdString()+ "/Documents/GitHub/QT3D/levels.txt" ;
    vector <int> rowVector(2);
    int row = 0;
    ifstream myfile (path);
    if(myfile.is_open())
    {
        while(myfile.good())
        {
            levelArray.push_back(rowVector);
            for(int col = 0; col < 2;col++){
                myfile >> levelArray[row][col];
            }
            row++;
        }
    }
    else{

        qDebug() << "Unable to open file";
    }
    myfile.close();
    amountOfLevels = row;

}

void Levels::printArray()
{
    for(int i = 0; i <amountOfLevels; i++)
    {
        for(int j = 0; j < 2; j++)
        {
            qDebug() <<  (unsigned int) (levelArray[i][j]) ;
        }

    }
}

int Levels::getAmountOfLevels() const
{
    return amountOfLevels;
}

void Levels::setAmountOfLevels(int value)
{
    amountOfLevels = value;
}


