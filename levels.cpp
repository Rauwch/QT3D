#include "levels.h"

Levels::Levels(QObject *parent) : QObject(parent)
{
    getLevelAmount();
}
/* method that checks if the save file already exists,
 * if not it will create it else it will read it out
 * and fill the array */
void Levels::getLevelAmount()
{
    QString path = QDir::currentPath() + "/levels.txt";
    QFile * newFile = new QFile(path);
    QFile * file = new QFile(":/assets/Levels/levels.txt");
    QTextStream stream(newFile);
    QString line;
    QStringList list;
    /* boolean gets set if the newFile already exists*/
    bool fileExists = newFile->exists();
    vector <int> rowVector(2);
    int row = 0;
    if(!file->open(QIODevice::ReadOnly| QIODevice::Text))
    {
        qDebug()<< "error opening levels";
        return;
    }

    if(newFile->open(QIODevice::ReadWrite | QIODevice::Text))
    {
        /*write all the content of file in newFile*/
        if(!fileExists){
            QTextStream in(file);
            QString leaderPath;

            while (!in.atEnd())
            {
                line = in.readLine();
                stream << line;
                stream << endl;

                row++;
                /* create leaderboard file for each level */
                leaderPath= QDir::currentPath() + "/leaderboard"+QString::number(row)+ ".txt";
                QFile * leaderBoard = new QFile(leaderPath);
                /* opening a file that doesn't exist yet will creat this file */
                if(!leaderBoard->open(QIODevice::ReadWrite| QIODevice::Text))
                {
                    qDebug()<< leaderBoard->errorString();
                    return;
                }
                leaderBoard->close();
            }
        }
        stream.seek(0);
        row = 0;
        /*add the content of newFile to the levelArray*/
        while (!stream.atEnd())
        {
            line = stream.readLine();
            if (!line.isEmpty()&&!line.isNull()){
                list=line.split(" ");
                levelArray.push_back(rowVector);
                for(int col = 0; col < 2; col++){
                    levelArray[row][col] = list.at(col).toInt();
                }
                row++;
            }
        }
    }

    amountOfLevels = row;
    file->close();
    newFile->close();
}
/* print array used for debugging */
void Levels::printArray()
{
    for(int i = 0; i <amountOfLevels; i++)
    {
        for(int j = 0; j < 4; j++)
        {
            qDebug() <<  (unsigned int) (levelArray[i][j]) ;
        }
    }
}
/* method that is caleld after completing a level to
 * store the progress in the array and the text file */
void Levels::refreshTextFile()
{
    QString path = QDir::currentPath() + "/levels.txt";
    QFile * file = new QFile(path);
    QTextStream output(file);
    /*Opening a file with the to write will clear the content of that file */
    if (!file->open(QIODevice::WriteOnly | QIODevice::Text))
    {
        qDebug() << file->errorString();
        return;
    }

    for(int i = 0; i <amountOfLevels; i++)
    {

        for(int j = 0; j < 2; j++)
        {
            output << levelArray[i][j] << " " ;
        }
        output << endl;
    }
}
/* method to reset the progress */
void Levels::resetLevels()
{
    QString path = QDir::currentPath() + "/levels.txt";
    QFile * newFile = new QFile(path);
    QFile * file = new QFile(":/assets/Levels/levels.txt");
    QTextStream stream(newFile);
    QString line;
    QStringList list;
    levelArray.clear();
    /* boolean gets set if the newFile already exists*/
    //bool fileExists = newFile->exists();
    vector <int> rowVector(2);
    int row = 0;
    if(!file->open(QIODevice::ReadOnly| QIODevice::Text))
    {
        qDebug()<< "error opening levels";
        return;
    }

    if(newFile->open(QIODevice::ReadWrite | QIODevice::Text))
    {
        /*write all the content of file in newFile*/
        QTextStream in(file);
        QString leaderPath;

        while (!in.atEnd())
        {
            line = in.readLine();
            stream << line;
            stream << endl;

            row++;
            /* create leaderboard file for each level */
            leaderPath= QDir::currentPath() + "/leaderboard"+QString::number(row)+ ".txt";
            QFile * leaderBoard = new QFile(leaderPath);
            QTextStream leader(leaderBoard);
            /* opening a file that doesn't exist yet will creat this file */
            if(leaderBoard->open(QIODevice::WriteOnly | QIODevice::Text))
            {
              leader << endl;

            }
            leaderBoard->close();
        }
        stream.seek(0);
        row = 0;
        /*add the content of newFile to the levelArray*/
        while (!stream.atEnd())
        {
            line = stream.readLine();
            if (!line.isEmpty()&&!line.isNull()){
                list=line.split(" ");
                levelArray.push_back(rowVector);
                for(int col = 0; col < 2; col++){
                    levelArray[row][col] = list.at(col).toInt();
                }
                row++;
            }
        }
    }
    file->close();
    newFile->close();
}

int Levels::getAmountOfStars(int level) const
{
    return levelArray[level][1];
}

void Levels::setAmountOfStars(int numClicks, int twoStar, int threeStar)
{
    /*levels go form 1-... and the level array goes from 0-... */

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




