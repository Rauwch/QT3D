#ifndef LEVELS_H
#define LEVELS_H


#include <QObject>
#include <iostream>
#include <fstream>
#include <string>
#include <QDebug>

using namespace std;

class Levels : public QObject
{
    Q_OBJECT

public:
    explicit Levels(QObject *parent = 0);

    Q_INVOKABLE void getLevelAmount();
    void printArray();
    void fillLevelArray();


signals:


public slots:


private:
    vector< vector <int>> levelArray;
    int amountOfLevels;



};

#endif // LEVELS_H
