/*************************************************************************
	> File Name: 5.cpp
	> Author: 22h 
	> Created Time: 2018年03月06日 星期二 22时29分16秒
 ************************************************************************/

#include<bits/stdc++.h>
using namespace std;

double Celsius2Fahrenheit(double Celsius)
{
    return 1.8 * Celsius + 32.0;
}

int main(void)
{
    double c = 0;
    cout<<"Please enter a Celsius value: ";
    cin>>c;
    cout<<c<<" degrees Celsius is "
        <<Celsius2Fahrenheit(c)
        <<" degree Fahrenheit."<<endl;
    return 0;
}

