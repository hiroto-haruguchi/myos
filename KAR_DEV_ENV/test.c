#include <stdio.h>

void myprintf(int,int);

int main()
{
 int i=0;
 for(i=0;i<5;i++) myprintf(i,i+1);

 return;
}

void myprintf(int i,int ii){
printf("%d %d\n",i,ii);

}
