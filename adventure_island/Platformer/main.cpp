#include <QApplication>
#include <VPApplication>

#include <QQmlApplicationEngine>
#include "gameInfo.h"


int main(int argc, char *argv[])
{

    QApplication app(argc, argv);

    VPApplication vplay;


    QQmlApplicationEngine engine;
    vplay.initialize(&engine);

    // use this during development
    // for PUBLISHING, use the entry point below
    qmlRegisterType<GameInfo>("game.info",1,0,"GameInfo");
    vplay.setMainQmlFileName(QStringLiteral("qml/PlatformerMain.qml"));

    engine.load(QUrl(vplay.mainQmlFileName()));

    return app.exec();
}

