/*************************************************************************
	> File Name: 3.cpp
	> Author: 22h 
	> Created Time: 2018年03月15日 星期四 22时42分03秒
 ************************************************************************/

#include<bits/stdc++.h>
using namespace std;
int main(void)
{
    double d, m, s;
    cout << "Enter a latitude in degrees, minutes, and seconds" << endl;
    cout << "First, enter the degrees: ";
    cin >> d;
    cout << "Second, enter the minutes of arc: ";
    cin >> m;
    cout << "Third, enter the seconds of arc: ";
    cin >> s;
    double ans = d + m / 60 + s / 3600;
    cout << d <<" degrees,";
    cout << m << " minutes,";
    cout << s << " seconds = ";
    cout << ans<<" degrees."<<endl;
    return 0;
}
