#include<iostream>
#include<vector>
#include<stdio.h>

using namespace std;

int main(){
    int time;
    cin >> time;
    for(int caseNum = 1;caseNum<=time;caseNum++){
        int totalServer, needServer;
        cin>>totalServer>>needServer;
        int serverList[totalServer];
        int mark[totalServer];
        for (int i = 0; i < totalServer; i++)
        {
            int price;
            //scanf("%d ",&price);
            cin >> price;
            mark[i] = 0;
            serverList[i] = price;
            //printf("%d ",serverList[i]);
            
        }
        int buy = 0, cost = 0;
        for (buy = 0; buy < needServer;){
            int min = 99999, minIndex = -1;
            //find min cost
            for (int i = 0; i < totalServer; i++)
            {
                if(mark[i]==0 && min > serverList[i]){
                    min = serverList[i];
                    minIndex = i;
                }
            }
            mark[minIndex] = 1;
            cost += serverList[minIndex];
            buy++;
            if (minIndex == 0 && mark[1]==0)
            {
                buy++;
                mark[1] = 1;
            }
            else if(minIndex == totalServer - 1 && mark[1]==0){
                buy++;
                mark[totalServer-1] = 1;
            }
            else{
                if(serverList[minIndex-1] > serverList[minIndex+1]){
                    buy++;
                    mark[minIndex - 1] = 1;
                }
                else if (serverList[minIndex-1] < serverList[minIndex+1]){
                    buy++;
                    mark[minIndex+1] = 1;
                }
                // else{//equal
                //     if(serverList[minIndex+1])
                // }
            }
        }
        printf("Case %d: %d\n", caseNum, cost);
    }
    return 0;
}