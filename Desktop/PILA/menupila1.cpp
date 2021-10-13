#include<iostream>
using namespace std;

//void push(int A[], int tope, int w);

void incrementar(int);

int main(){
	int w;
	cin>>w;
	cout<<"Valor actual: "<<w<<endl;
	incrementar(w);
	cout<<"Valor incrementado: "<<w;
	return 0;
}

void incrementar(int &x){
	x=x+1;
}
