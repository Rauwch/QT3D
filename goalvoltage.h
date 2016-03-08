#ifndef GOALVOLTAGE_H
#define GOALVOLTAGE_H


class GoalVoltage
{
public:
    GoalVoltage(int x, int y, int node);

    int getX() const;
    void setX(int value);

    int getY() const;
    void setY(int value);

    int getNode() const;
    void setNode(int value);

    float getVoltage() const;
    void setVoltage(float value);

    bool getMatch() const;
    void setMatch(bool value);

private:
    int x, y, node;
    float voltage;
    bool match;
};

#endif // GOALVOLTAGE_H
