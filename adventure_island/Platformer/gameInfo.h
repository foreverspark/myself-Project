#ifndef DATEMESSAGE_H
#define DATEMESSAGE_H

#include <QObject>

class GameInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int lifeNumber READ lifeNumber WRITE setLifeNumber NOTIFY lifeNumberChanged)
    Q_PROPERTY(int starNumber READ starNumber WRITE setStarNumber NOTIFY starNumberChanged)
    Q_PROPERTY(int coinNumber READ coinNumber WRITE setCoinNumber NOTIFY coinNumberChanged)
    Q_PROPERTY(int time READ time WRITE setTime NOTIFY TimeChanged)

public:
    explicit GameInfo(QObject *parent = nullptr);

    //getting
    Q_INVOKABLE int lifeNumber(){ return m_lifeNumber;}
    Q_INVOKABLE int starNumber(){ return m_starNumber;}
    Q_INVOKABLE int coinNumber(){return m_coinNumber;}
    Q_INVOKABLE int time(){return m_time;}

    //setting
    Q_INVOKABLE void setLifeNumber(int lifeNumber);
    Q_INVOKABLE void setCoinNumber(int coinNumber);
    Q_INVOKABLE void setStarNumber(int starNumber);
    Q_INVOKABLE void setTime(int time);


    Q_INVOKABLE void lifeNumberDecrease();
    Q_INVOKABLE void starNumberAdd(){m_starNumber++;emit starNumberChanged();}
    Q_INVOKABLE void coinNumberAdd(){m_coinNumber++;emit coinNumberChanged();}
    Q_INVOKABLE void timeDecrease();

    //method
    Q_INVOKABLE void reset();

signals:
     void lifeNumberChanged();
     void starNumberChanged();
     void coinNumberChanged();
     void TimeChanged();
     void timeEnded();
     void gameOver();
     void success();
     void fail();

private:
    int m_lifeNumber = 5;
    int m_coinNumber = 0;
    int m_starNumber = 0;
    int m_time = 70;
};

#endif // DATEMESSAGE_H
