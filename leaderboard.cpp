#include "leaderboard.h"

Leaderboard::Leaderboard(QObject *parent) : QObject(parent)
{
    this->setLowestEntry(0);
}

void Leaderboard::readLeaderboard(int level)
{
    //qDebug() << "INSIDE READ LEADER BOARD";
    QFile * file = new QFile(QDir::currentPath() + "/leaderboard"+QString::number(level)+ ".txt");
    vector <QString> rowVector(3);
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
                //qDebug()<< "this is the line: " <<line;
                levelboard.push_back(rowVector);
                for(int col = 0; col < 3; col++){
                    levelboard[row][col] = list.at(col);
                    if(list.at(2).toInt() > lowestEntry)
                    {
                            lowestEntry = list.at(2).toInt();
                    }
                }
                row++;
            }

        }

    }
    else{

        qDebug() << "Unable to open file";
    }
    amountOfEntries = row;
    //qDebug() << "rownums: " << row;
    //qDebug() << "lowest entry: " << lowestEntry;
    file->close();
}

void Leaderboard::addEntry(QString name, int stars, int clicks)
{
    //qDebug() << "in add entry";
    int checkClicks = 0;
    int i = 0;
    while(clicks >= checkClicks)
    {
        if(levelboard.size() == 0)
            break;
        //qDebug() << "clicks: " << clicks << " checkClicks "<<  checkClicks;
        if(i >= levelboard.size())
        {
            i++;
            break;

        }
        checkClicks = levelboard[i][2].toInt();

        i++;
         //qDebug() << "in while";
    }
    //qDebug() << " after a while";
    if(levelboard.size() != 0)
        i--;
    vector <QString> rowVector(3);
     //qDebug() << "before insert";
    levelboard.insert(levelboard.begin()+i,rowVector);
    levelboard[i][0] = name;
    levelboard[i][1] =  QString::number(stars);
    levelboard[i][2] =  QString::number(clicks);
    amountOfEntries++;
}

void Leaderboard::writeLeaderBoard(int level)
{
    //qDebug() << "Inside refreshTextFile";
    QString path = QDir::currentPath() + "/leaderboard"+ QString::number(level)  +".txt";
    QFile * file = new QFile(path);
    if (!file->open(QIODevice::WriteOnly | QIODevice::Text))
    {
        qDebug() << file->errorString();
        return;
    }

    QTextStream output(file);

    for(int i = 0; i <amountOfEntries; i++)
    {
        //qDebug() <<"Writing to textfile";
        for(int j = 0; j < 3; j++)
        {
            output << levelboard[i][j] << " " ;
            //qDebug() << levelboard[i][j] << " ";
        }
        output << endl;

    }
 file->close();
}

QString Leaderboard::giveName(int index)
{
    QString name = 0;
    name = levelboard[index][0];
    return name;
}

int Leaderboard::giveStars(int index)
{

    QString stars;
    stars = levelboard[index][1];
    return stars.toInt();
}

int Leaderboard::giveClicks(int index)
{
    QString clicks;
    clicks = levelboard[index][2];
    return clicks.toInt();
}

int Leaderboard::getAmountOfEntries() const
{
    return amountOfEntries;
}

void Leaderboard::setAmountOfEntries(int value)
{
    amountOfEntries = value;
}

int Leaderboard::getLowestEntry() const
{
    return lowestEntry;
}

void Leaderboard::setLowestEntry(int value)
{
    lowestEntry = value;
}
