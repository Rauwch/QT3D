#ifndef LINKER_H
#define LINKER_H


#include <QObject>

class Linker : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int height READ getMyHeight WRITE setMyHeight NOTIFY heightChanged)
    Q_PROPERTY(int speed READ getMySpeed WRITE setMySpeed NOTIFY speedChanged)
public:
    explicit Linker(QObject *parent = 0);



    Q_INVOKABLE int getMyHeight() const;
    Q_INVOKABLE void setMyHeight(int value);

    Q_INVOKABLE int getMySpeed() const;
    Q_INVOKABLE void setMySpeed(int value);

signals:

    void heightChanged(int h);
    void speedChanged(int s);
public slots:


private:
    int myHeight;
    int mySpeed;

};

#endif // LINKER_H
