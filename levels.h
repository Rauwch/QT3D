#ifndef LEVELS_H
#define LEVELS_H


#include <QObject>
#include <iostream>
#include <fstream>
#include <string>
#include <QDebug>
#include <QDir>

using namespace std;

class Levels : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int amountOfLevels READ getAmountOfLevels WRITE setAmountOfLevels NOTIFY amountOfLevelsChanged)
    //Q_PROPERTY(int amountOfStars READ getAmountOfStars WRITE setAmountOfStars NOTIFY amountOfStarsChanged)

public:
    explicit Levels(QObject *parent = 0);

    Q_INVOKABLE void getLevelAmount();
    void printArray();
    void fillLevelArray();
    Q_INVOKABLE int getAmountOfStars(int level) const;
    Q_INVOKABLE void setAmountOfStars(int level);


    Q_INVOKABLE int getAmountOfLevels() const;
    Q_INVOKABLE void setAmountOfLevels(int value);

signals:
     void amountOfLevelsChanged(int a);
     void amountOfStarsChanged();
public slots:


private:
    vector< vector <int>> levelArray;
    int amountOfLevels;



};

#endif // LEVELS_H
