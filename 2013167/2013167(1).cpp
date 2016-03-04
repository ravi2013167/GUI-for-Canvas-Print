#include<bits/stdc++.h>
#define repl(i,a,b) for(i=a; i<b; i++)
using namespace std;
int main()
        
{
        long t, i, j, k, l;
        long n;
 
		cout<<"Enter Number Of Points:"; 
        cin>>n;
        long double x[2000], y[2000];
        cout<<"Enter Points:";
        long double ymax=0;
        repl(i,0,n){
                cin>>x[i]>>y[i];        
                ymax = max(y[i], ymax);
        }
        long double dia;
        cout<<"Enter Tool Diameter:";
        cin>>dia;
        long double iy = y[0]+dia/2;
        long double slope = (y[0]-y[n-1])/(x[0]-x[n-1]);        
        long double ix = (iy-y[0])/slope + x[0];
        int turn=1;
        cout<<ix<<" "<<iy<<endl;
        i=0;
        j=n-1;
        while(iy < ymax){
                
                if(turn&1){
                        while(i < n-1 && y[i+1] < iy)
                                i++;
                        slope = (y[i]-y[i+1])/(x[i]-x[i+1]);
                        ix=(iy-y[i])/slope + x[i];
                        if(!((ix == x[i] && iy == y[i]) || (ix == x[i+1] && iy == y[i+1])))                        
                                cout<<ix<<" "<<iy<<endl;        
                        iy+=dia;
                        if(iy >= ymax)break;
                        while(i < n-1 && y[i+1] < iy)
                                i++;
                        slope = (y[i]-y[i+1])/(x[i]-x[i+1]);
                        ix=(iy-y[i])/slope + x[i];
                        if(!((ix == x[i] && iy == y[i]) || (ix == x[i+1] && iy == y[i+1])))
                                cout<<ix<<" "<<iy<<endl;                                        
                }
                else{
                        while(j && y[j] < iy)
                                j--;
                        k=(j+1)%n;
                        slope = (y[j]-y[k])/(x[j]-x[k]);
                        ix = (iy - y[j])/slope + x[j];
                        if(!((ix == x[i] && iy == y[i]) || (ix == x[i+1] && iy == y[i+1])))
                                cout<<ix<<" "<<iy<<endl;
                        iy+=dia;
                        if(iy >= ymax)break;
                        while(j && y[j] < iy)
                                j--;
                        
                        k=(j+1)%n;
                        slope = (y[j]-y[k])/(x[j]-x[k]);
                        ix=(iy-y[j])/slope + x[j];
                        if(!((ix == x[i] && iy == y[i]) || (ix == x[i+1] && iy == y[i+1])))
                                cout<<ix<<" "<<iy<<endl;        
                }
                turn=1-turn;
        }                        
        return 0;
}
