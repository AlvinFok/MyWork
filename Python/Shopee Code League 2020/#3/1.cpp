#include <iostream>
#include <vector>
#include <stdio.h>
#include<algorithm>

using namespace std;

int main()
{
    int time;
    cin >> time;
    for (int caseNum = 1; caseNum <= time; caseNum++)
    {
        int data, search;
        cin >> data >> search;
        vector<vector<string> > str, word;
        //vector<string> word;
        string junk;
        getline(cin, junk);
        for (int i = 0; i < data; i++)
        {
            string line;
            vector<string> tmp;
            while (getline(cin, line, ' '))
            {
                tmp.push_back(line);
            }
            str.push_back(tmp);
        }
        for (int i = 0; i < search; i++)
        {
            string line;
            vector<string> tmp;
            while(getline(cin, line, ' ')){
                tmp.push_back(line);
            }
            word.push_back(tmp);
        }
        printf("Case %d:\n", caseNum);
        for (int i = 0; i < word.size(); i++)
        {
            
                int count = 0;
                for (int k = 0; k < str.size(); k++){
                    int flag = 0;
                    StringIterator it = find(str.begin(), str.end(), word[i][0]);
                    if (find(str.begin(), str.end(), word[i][0]) != str.end())
                    {
                        for (int j = 0;j<word[i].size();j++){
                            if()
                        }
                    }
                }
            

            printf("%d\n", count);
        }
    }
    return 0;
}