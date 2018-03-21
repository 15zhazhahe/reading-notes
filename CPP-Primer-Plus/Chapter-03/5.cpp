/*************************************************************************
	> File Name: 5.cpp
	> Author: 22h 
	> Created Time: 2018年03月15日 星期四 23时07分29秒
 ************************************************************************/

#include<bits/stdc++.h>
using namespace std;
int main(void)
{
    long long world_num, US_num;
    cout << "Enter the world's popluation: ";
    cin >> world_num;
    cout << "Enter the popluation of US: ";
    cin >> US_num;
    double perect = 100.0 * US_num / world_num;
    cout << "The popluation of the US is " ;
    cout << perect << "% of the world of popluation. "<<endl;
    return 0;
}
