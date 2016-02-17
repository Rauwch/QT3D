#include "levels.h"


using namespace std;

Levels::Levels(QObject *parent) : QObject(parent)
{

}

void Levels::readLevels() const
{
    string line;
    ifstream myfile ("levels.txt");
    if(myfile.is_open())
    {
        while(getline(myfile,line))
        {
            cout << line << '\n';
        }
    }
    else cout << "Unable to open file";

}
