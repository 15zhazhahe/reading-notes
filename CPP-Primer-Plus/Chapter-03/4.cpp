/*************************************************************************
	> File Name: 4.cpp
	> Author: 22h 
	> Created Time: 2018年03月15日 星期四 22时48分19秒
 ************************************************************************/

#include<bits/stdc++.h>
using namespace std;
int main(void)
{
    long long seconds,tmp;
    int y = 0, h = 0, m = 0, s = 0;
    cout << "Enter the number of seconds: ";
    cin >> seconds;
    tmp = seconds;
    s = tmp % 60;
    tmp /= 60;
    m = tmp % 60;
    tmp /= 60;
    h = tmp % 24;
    tmp /= 24;
    y = tmp;
    cout << seconds << " seconds = ";
    cout << y << " years, " << h << " hours,";
    cout << m << " minutes, " << s << " seconds.";
    return 0;
}
