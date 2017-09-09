#include "gameInfo.h"

GameInfo::GameInfo(QObject *parent):QObject(parent)
{

}

void GameInfo::lifeNumberDecrease(){
    m_lifeNumber--;
    if(m_lifeNumber == 0){
        emit gameOver();
    }
    emit lifeNumberChanged();
}

void GameInfo::timeDecrease(){
    m_time--;
    if(m_time == 0){
        emit timeEnded();
        if(m_starNumber < 3)
            emit fail();
        else if(m_starNumber == 3){
            emit success();
        }
    }
    emit TimeChanged();

}

void GameInfo::setLifeNumber(int lifeNumber)
{
    if(m_lifeNumber != lifeNumber){
        m_lifeNumber = lifeNumber;
        emit lifeNumberChanged();
    }
}

void GameInfo::setCoinNumber(int coinNumber)
{
    if(m_coinNumber != coinNumber){
        m_coinNumber = coinNumber;
        emit coinNumberChanged();
    }
}

void GameInfo::setStarNumber(int starNumber)
{
    if(m_starNumber != starNumber){
        m_starNumber = starNumber;
        emit starNumberChanged();
    }
}

void GameInfo::setTime(int time)
{
    if(m_time != time){
        m_time = time;
        emit TimeChanged();
    }
}

void GameInfo::reset()
{
    m_lifeNumber = 5;
    m_coinNumber = 0;
    m_starNumber = 0;
    m_time = 70;
    emit TimeChanged();
    emit lifeNumberChanged();
    emit starNumberChanged();
    emit coinNumberChanged();
}
















