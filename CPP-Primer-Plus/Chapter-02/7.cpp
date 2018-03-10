/*************************************************************************
	> File Name: 7.cpp
	> Author: 22h 
	> Created Time: 2018年03月06日 星期二 22时41分37秒
 ************************************************************************/

#include<bits/stdc++.h>
using namespace std;

void display(int hours, int minutes)
{
    cout<<"Time: "<<hours<<":"<<minutes<<endl;
    return ;
}

int main(void)
{
    int hours, minutes;
    cout<<"Enter the number of hours: ";
    cin>>hours;
    cout<<"Enter the number of minutes: ";
    cin>>minutes;
    display(hours, minutes);
    return 0;
}
