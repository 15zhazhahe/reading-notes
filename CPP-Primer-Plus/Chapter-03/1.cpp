/*************************************************************************
	> File Name: 1.cpp
	> Author: 22h 
	> Created Time: 2018年03月15日 星期四 21时58分57秒
 ************************************************************************/

#include<bits/stdc++.h>
using namespace std;
const int Foot2Inch = 12;
int main(void)
{
    int inch = 0;
    cout << "Please input you height in inch:___\b\b\b";
    cin >> inch;
    int foot = inch / Foot2Inch;
    int rinch = inch % Foot2Inch;
    cout<<"Your height in inch is "<<inch<<" inch."<<endl;
    cout<<"Your height in foot is "<<foot<<" foot "<<rinch<<" inch."<<endl;
    return 0;
}
