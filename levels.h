#ifndef LEVELS_H
#define LEVELS_H


#include <QObject>
#include <iostream>
#include <fstream>
#include <string>
#include <QDebug>
#include <QDir>
#include <QStandardPaths>

using namespace std;
/*Class that stores the level progres */
class Levels : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int amountOfLevels READ getAmountOfLevels WRITE setAmountOfLevels NOTIFY amountOfLevelsChanged)    
public:
    explicit Levels(QObject *parent = 0);

    Q_INVOKABLE void getLevelAmount(); 
    Q_INVOKABLE void refreshTextFile();
    Q_INVOKABLE void resetLevels();
    Q_INVOKABLE int getAmountOfStars(int level) const;
    Q_INVOKABLE void setAmountOfStars(int numClicks, int twoStar, int threeStar);
    Q_INVOKABLE int getAmountOfLevels() const;
    Q_INVOKABLE void setAmountOfLevels(int value);
    Q_INVOKABLE int getCurrentLevel() const;
    Q_INVOKABLE void setCurrentLevel(int value);

    void printArray();

signals:
    void amountOfLevelsChanged(int a);
    void amountOfStarsChanged();
public slots:
private:
    vector< vector <int>> levelArray;
    int amountOfLevels;
    int currentLevel;

};

#endif // LEVELS_H
