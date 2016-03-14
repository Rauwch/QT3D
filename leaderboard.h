#ifndef LEADERBOARD_H
#define LEADERBOARD_H

#include <QObject>
#include <QString>
#include <QFile>
#include <QTextStream>

#include <vector>

using namespace std;
class Leaderboard : public QObject
{
Q_OBJECT
public:
    Leaderboard();

   //read file
    Q_INVOKABLE void readLeaderboard(QString s);

private:
    QString filename;
    vector< vector <QString>> levelboard;
    int amountOfEntries;
};

#endif // LEADERBOARD_H
