#ifndef LEADERBOARD_H
#define LEADERBOARD_H

#include <QObject>
#include <QString>
#include <QFile>
#include <QTextStream>
#include <QDebug>
#include <QDir>
#include <vector>

using namespace std;
class Leaderboard : public QObject
{
Q_OBJECT
public:
    explicit Leaderboard(QObject *parent = 0);

   //read file
    Q_INVOKABLE void readLeaderboard(int level);
    Q_INVOKABLE void addEntry(QString name, int stars, int clicks);
    Q_INVOKABLE void writeLeaderBoard(int level);
    Q_INVOKABLE QString giveName(int index);
    Q_INVOKABLE int giveStars(int index);
    Q_INVOKABLE int giveClicks(int index);
    Q_INVOKABLE int getAmountOfEntries() const;
    Q_INVOKABLE void setAmountOfEntries(int value);

    Q_INVOKABLE int getLowestEntry() const;
    Q_INVOKABLE void setLowestEntry(int value);

    Q_INVOKABLE int getHighScore() const;
    Q_INVOKABLE void setHighScore(int value);

private:
    QString filename;
    vector< vector <QString>> levelboard;
    int amountOfEntries;
    int lowestEntry;
    int highScore;
};

#endif // LEADERBOARD_H
