/*************************************************************************
	> File Name: 2.cpp
	> Author: 22h 
	> Created Time: 2018年03月15日 星期四 22时28分19秒
 ************************************************************************/

#include<bits/stdc++.h>
using namespace std;
const int Foot2Inch = 12;
const double Inch2Meter = 0.0254;
const double Kilo2Pound = 2.2;
int main(void)
{
    double height_foot, height_inch, height_meter;
    double weight_pound,weight_kilo;
    cout << "Please input your height in foot and inch:"<<endl;
    cout << "First enter the foot: ";
    cin >> height_foot;
    cout << "Then enter the inch: ";
    cin >> height_inch;

    cout << "Input your weight in pound: ";
    cin >> weight_pound;
    height_meter = (height_foot * Foot2Inch + height_inch) * Inch2Meter;
    weight_kilo = weight_pound / Kilo2Pound;

    double BMI = weight_kilo / (height_meter * height_meter);
    cout << "Your BIM is "<< BMI <<endl;

    return 0;
}
