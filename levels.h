#ifndef LEVELS_H
#define LEVELS_H


#include <QObject>
#include <iostream>
#include <fstream>
#include <string>

class Levels : public QObject
{
    Q_OBJECT

public:
    explicit Levels(QObject *parent = 0);

    Q_INVOKABLE void readLevels() const;


signals:


public slots:


private:


};

#endif // LEVELS_H
