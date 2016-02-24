#include "levels.h"




Levels::Levels(QObject *parent) : QObject(parent)
{
   getLevelAmount();
   printArray();

}



void Levels::getLevelAmount()
{
    string path = QDir::homePath().toStdString()+ "/Documents/GitHub/QT3D/levels.txt" ;
    vector <int> rowVector(4);
    int row = 0;
    fstream myfile (path);
    if(myfile.is_open())
    {
        while(myfile.good())
        {
            levelArray.push_back(rowVector);
            for(int col = 0; col < 4;col++){
                myfile >> levelArray[row][col];
            }
            row++;
        }

    }
    else{

        qDebug() << "Unable to open file";
    }

    myfile.close();
    row--;
    amountOfLevels = row;
    qDebug() << "rownums: " << row;

}

void Levels::printArray()
{
    for(int i = 0; i <amountOfLevels; i++)
    {
        for(int j = 0; j < 4; j++)
        {
            //qDebug() <<  (unsigned int) (levelArray[i][j]) ;
        }
    }
}

void Levels::refreshTextFile()
{
     string path = QDir::homePath().toStdString()+ "/Documents/GitHub/QT3D/levels.txt" ;
     fstream myfile (path);
     if(myfile.is_open())
     {
         for(int i = 0; i <amountOfLevels; i++)
         {
             for(int j = 0; j < 4; j++)
             {
                 myfile << levelArray[i][j] << " ";
             }
             myfile << "\n";
         }

     }
     else{

         qDebug() << "Unable to open file";
     }
}

int Levels::getAmountOfStars(int level) const
{
    int nrStars = 0;
    nrStars = levelArray[level][1];
    return nrStars;
}

void Levels::setAmountOfStars(int numClicks)
{
    int twoEarned = levelArray[currentLevel][2];
    int threeEarned = levelArray[currentLevel][3];
    if(numClicks <= threeEarned){
        levelArray[currentLevel][1] = 3;
    }
    else if(numClicks <= twoEarned){
        if(levelArray[currentLevel][1] < 2){
        levelArray[currentLevel][1] = 2;
        }
    }
    else{
        if(levelArray[currentLevel][1] < 1){
        levelArray[currentLevel][1] = 1;
        }
    }
    refreshTextFile();
}

int Levels::getAmountOfLevels() const
{
    return amountOfLevels;
}

void Levels::setAmountOfLevels(int value)
{
    amountOfLevels = value;
}

int Levels::getCurrentLevel() const
{
    return currentLevel;
}

void Levels::setCurrentLevel(int value)
{
    currentLevel = value;
}




