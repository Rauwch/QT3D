#include "leaderboard.h"

Leaderboard::Leaderboard(QObject *parent) : QObject(parent)
{
    this->setLowestEntry(0);
    this->setHighScore(0);
}
/* method that reads the text file
 * and stores it in an array */
void Leaderboard::readLeaderboard(int level)
{
    QFile * file = new QFile(QDir::currentPath() + "/leaderboard"+QString::number(level)+ ".txt");
    vector <QString> rowVector(3);
    QString line;
    QStringList list;
    int row = 0;
    if(file->open(QIODevice::ReadOnly| QIODevice::Text))
    {
        QTextStream in(file);
        while (!in.atEnd())
        {
            line = in.readLine();
            if (!line.isEmpty()&&!line.isNull()){
                list=line.split(" ");
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
    else
        qDebug() << file->errorString();

    if(levelboard.size()!=0)
        setHighScore((levelboard[0][2]).toInt());

    amountOfEntries = row;
    file->close();
}
/* method to add level to the array */
void Leaderboard::addEntry(QString name, int stars, int clicks)
{
    int checkClicks = 0;
    name = name.simplified();
    name.replace( " ", "_" );
    unsigned int i = 0;
    vector <QString> rowVector(3);
    while(clicks >= checkClicks)
    {
        if(levelboard.size() == 0)
            break;
        if(i >= levelboard.size())
        {
            i++;
            qDebug() << "i is groter dan size";
            break;
        }
        checkClicks = levelboard[i][2].toInt();
        i++;
    }
    if(levelboard.size() != 0)
        i--;
    levelboard.insert(levelboard.begin()+i,rowVector);
    levelboard[i][0] = name;
    levelboard[i][1] =  QString::number(stars);
    levelboard[i][2] =  QString::number(clicks);
    amountOfEntries++;
    if(amountOfEntries > 5)
    {
        levelboard.pop_back();
        amountOfEntries--;
    }
}
/* method to update the textfile */
void Leaderboard::writeLeaderBoard(int level)
{
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
        for(int j = 0; j < 3; j++)
        {
            output << levelboard[i][j] << " " ;
        }
        output << endl;
    }
    file->close();
}
/* getters and setter */
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

int Leaderboard::getHighScore() const
{
    return highScore;
}

void Leaderboard::setHighScore(int value)
{
    highScore = value;
}
