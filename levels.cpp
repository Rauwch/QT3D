#include "levels.h"




Levels::Levels(QObject *parent) : QObject(parent)
{
    getLevelAmount();
    printArray();

}



void Levels::getLevelAmount()
{
    QFile * file = new QFile(":/assets/Levels/levels.txt");
    //QFile * file = new QFile("levels.txt");
    //string path = QDir::homePath().toStdString()+ "/Documents/GitHub/QT3D/levels.txt" ;
    vector <int> rowVector(4);
    int row = 0;
    //fstream myfile (path);
    if(file->open(QIODevice::ReadOnly| QIODevice::Text))
    {
        QTextStream in(file);
        while (!in.atEnd())
        {
            QString line = in.readLine();
            if (!line.isEmpty()&&!line.isNull()){

                QStringList list=line.split(" ");

                levelArray.push_back(rowVector);
                for(int col = 0; col < 4; col++){
                    levelArray[row][col] = list.at(col).toInt();
                }
                row++;
            }

        }

    }
    else{

        qDebug() << "Unable to open file";
    }
    amountOfLevels = row;
    qDebug() << "rownums: " << row;
    file->close();

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
    qDebug() << "Inside refreshTextFile";
    QFile * file = new QFile(":/assets/Levels/levels.txt");
    if (!file->open(QIODevice::WriteOnly | QIODevice::Text))
    {
        qDebug() << file->errorString();
         return;
    }

    QTextStream output(file);

    for(int i = 0; i <amountOfLevels; i++)
    {
        qDebug() <<"Writing to textfile";
        for(int j = 0; j < 4; j++)
        {
            output << levelArray[i][j] << " " ;
            qDebug() << levelArray[i][j] << " ";
        }
        output << endl;

    }


}

int Levels::getAmountOfStars(int level) const
{
    int nrStars = 0;
    nrStars = levelArray[level][1];
    return nrStars;
}

void Levels::setAmountOfStars(int numClicks, int twoStar, int threeStar)
{
    int currentIndex = currentLevel - 1;

    if(numClicks <= threeStar){
        levelArray[currentIndex][1] = 3;
    }
    else if(numClicks <= twoStar){
        if(levelArray[currentIndex][1] < 2){
            levelArray[currentIndex][1] = 2;
        }
    }
    else{
        if(levelArray[currentIndex][1] < 1){
            levelArray[currentIndex][1] = 1;
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




