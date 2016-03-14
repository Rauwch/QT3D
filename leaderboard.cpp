#include "leaderboard.h"

Leaderboard::Leaderboard()
{

}

void Leaderboard::readLeaderboard(QString s)
{
//    filename = s;
//    QFile * file = new QFile(s);
//    //QFile * file = new QFile("levels.txt");
//    //string path = QDir::homePath().toStdString()+ "/Documents/GitHub/QT3D/levels.txt" ;
//    vector <int> rowVector(3);
//    int row = 0;
//    //fstream myfile (path);
//    if(file->open(QIODevice::ReadOnly| QIODevice::Text))
//    {
//        QTextStream in(file);
//        while (!in.atEnd())
//        {
//            QString line = in.readLine();
//            if (!line.isEmpty()&&!line.isNull()){

//                QStringList list=line.split(" ");

//                levelboard.push_back(rowVector);
//                for(int col = 0; col < 3; col++){
//                    levelboard[row][col] = list.at(col).toInt();
//                }
//                row++;
//            }

//        }

//    }
//    else{

//        qDebug() << "Unable to open file";
//    }
//    amountOfEntries = row;
//    qDebug() << "rownums: " << row;
//    file->close();
}
