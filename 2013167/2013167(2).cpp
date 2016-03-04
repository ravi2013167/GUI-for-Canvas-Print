//algorithm to find the path from through which the nozzle should move
#include<bits/stdc++.h>
#define repl(i,a,b) for(i=a; i<b; i++)
using namespace std;
struct line{
	long double x1, y1, x2, y2;
	line(){}	
	line(long double x1, long double x2, long double y1, long double y2){
		this->x1=x1; this->x2=x2;
		this->y1=y1; this->y2=y2;
	}
};
long double distance(long double x1, long double y1, long double x2, long double y2){
	return sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2));
}
int main()
{
        long t, i, j, k, l;
        long n;
        cout<<"Enter Number Of Points:"; 
        cin>>n;
        long double x[100], y[100];
        cout<<"Enter Points:";
        repl(i,0,n)
                cin>>x[i]>>y[i];        
        long double dia;
        cout<<"Enter Tool Diameter:";
        cin>>dia;
	long double r=dia/2;
	while(true){
		long double max_dis=0;
		repl(i,0,n)
		repl(j,i+1,n)
			max_dis=max(max_dis,distance(x[i], y[i], x[j], y[j]));
		if(max_dis <= r)break;
		vector<line> v;
	        repl(i,0,n){	

			j=(i+1)%n;
			long double diff=y[j]-y[i], t=r;
                        if((r*diff < 0 && diff > 0) || (r*diff >0 && diff<0))
                                t=-r;
                        if(diff == 0)
                        {
                                if(x[j]-x[i] < 0)
                                        t=-r;
                        }	
			if(y[j] == y[i]){
				v.push_back(line(x[i], y[i]+t, x[j], y[i]+t));	
				continue;
			}
			long double theta=atan((x[i]-x[j])/(y[j]-y[i]));			
			long double x1, x2, y1, y2;
			x1=x[i]+t*cos(theta);				
			x2=x[j]+t*cos(theta);
			y1=y[i]+t*sin(theta);
			y2=y[j]+t*sin(theta);
			v.push_back(line(x1, x2, y1, y2));
		}
		long double n_x[100], n_y[100];
		k=0;
		repl(i,0,v.size()){
			j=(i+1)%v.size();
			if(v[i].x1 == v[i].x2){
				long double slope=(v[j].y2-v[j].y1)/(v[j].x2-v[j].x1);
				n_y[k]=slope*(v[i].x1-v[j].x1)+v[j].y1;
				n_x[k]=v[i].x1;
				k++;
				continue;
			}
			if(v[j].x1 == v[j].x2){	
				long double slope=(v[i].y2-v[i].y1)/(v[i].x2-v[i].x1);
				n_y[k]=slope*(v[j].x1-v[i].x1)+v[i].y1;
				n_x[k]=v[j].x1;
				k++;
				continue;
			}
			long double slope1=(v[i].y1-v[i].y2)/(v[i].x1-v[i].x2);
			long double slope2=(v[j].y1-v[j].y2)/(v[j].x1-v[j].x2);
			long double tempx=(v[j].y1-v[i].y1+slope1*v[i].x1+slope2*v[j].x1)/(slope1-slope2);
			long double tempy=slope1*(tempx-v[i].x1)+v[i].y1;
			n_x[k]=tempx;
			n_y[k]=tempy;
			k++;
		}	
		repl(i,0,k){
			x[i]=n_x[i];y[i]=n_y[i];
			cout<<x[i]<<" "<<y[i]<<endl;
		}
		break;
	}	
	return 0;
}