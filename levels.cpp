#include "levels.h"




Levels::Levels(QObject *parent) : QObject(parent)
{
    getLevelAmount();
    printArray();

}


void Levels::getLevelAmount()
{
    QString path = QDir::currentPath() + "/levels.txt";
    QFile * newFile = new QFile(path);
    QFile * file = new QFile(":/assets/Levels/levels.txt");
    bool fileExists = newFile->exists();
    vector <int> rowVector(2);
    int row = 0;
    // qDebug() << "print newFIle" << newFile;
    if(file->open(QIODevice::ReadOnly| QIODevice::Text))
    {
        qDebug()<< "open file";
    }
    QTextStream in(file);
    if(newFile->open(QIODevice::ReadWrite | QIODevice::Text))
    {
        //als de file nog niet bestaat
        QTextStream stream(newFile);
        if(!fileExists){
            while (!in.atEnd())
            {
                QString line = in.readLine();
                stream << line;
                stream << endl;
                //create leaderboardFiles
                row++;
                QString leaderPath= QDir::currentPath() + "/leaderboard"+QString::number(row)+ ".txt";
                qDebug() << " PATH:  " << leaderPath;
                QFile * leaderBoard = new QFile(leaderPath);
                if(leaderBoard->open(QIODevice::ReadWrite| QIODevice::Text))
                {
                    qDebug()<< "open file";
                }
                leaderBoard->close();
            }
        }
        stream.seek(0);
        row = 0;
        while (!stream.atEnd())
        {

            QString line = stream.readLine();
            if (!line.isEmpty()&&!line.isNull()){
                //qDebug() << "add level";
                QStringList list=line.split(" ");

                levelArray.push_back(rowVector);
                for(int col = 0; col < 2; col++){
                    levelArray[row][col] = list.at(col).toInt();
                }
                row++;
            }

        }

    }
    amountOfLevels = row;
    qDebug() << "rownums: " << row;
    file->close();
    newFile->close();

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
    //qDebug() << "Inside refreshTextFile";
    QString path = QDir::currentPath() + "/levels.txt";
    QFile * file = new QFile(path);
    if (!file->open(QIODevice::WriteOnly | QIODevice::Text))
    {
        qDebug() << file->errorString();
        return;
    }

    QTextStream output(file);

    for(int i = 0; i <amountOfLevels; i++)
    {
        //qDebug() <<"Writing to textfile";
        for(int j = 0; j < 2; j++)
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




