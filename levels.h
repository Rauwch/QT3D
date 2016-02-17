#ifndef LEVELS_H
#define LEVELS_H


#include <QObject>
#include <iostream>
#include <fstream>
#include <string>
#include <QDebug>

class Levels : public QObject
{
    Q_OBJECT

public:
    explicit Levels(QObject *parent = 0);

    Q_INVOKABLE void readLevels();


    Q_INVOKABLE int getTester() const;
    Q_INVOKABLE void setTester(int value);

signals:


public slots:


private:
    int tester;

};

#endif // LEVELS_H
