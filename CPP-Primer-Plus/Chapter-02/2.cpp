/*************************************************************************
	> File Name: 2.cpp
	> Author: 22h
	> Created Time: 2018年03月06日 星期二 22时10分12秒
    > Problem: 以long为单位的距离，将其转化成单位为码(一long等于220码)
 ************************************************************************/

#include<iostream>
using namespace std;
int main(void)
{
    int dis;
    cout<<"Please input distance(long): ";
    cin>>dis;
    cout<<"distance: "<<dis*220<<endl;
    return 0;
}
