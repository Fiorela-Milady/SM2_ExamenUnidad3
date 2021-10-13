#include<iostream>
#define MAX 20
using namespace std;

void push(int A[], int &tope, int w);
void imprime(int A[], int tope);
int pop(int A[], int &tope);

int main(){
	int A[MAX];
	int tope = -1, op=0;
	do{
		system("cls");
		cout<<"OPERACIONES CON PILAS"<<endl;
		cout<<"---------------------"<<endl;
		cout<<"1. Insertar un elemento"<<endl;
		cout<<"2. Extraer un elemento"<<endl;
		cout<<"3. Mostrar la pila"<<endl;
		cout<<"0. Salir"<<endl;
		cout<<"Elija una opcion: "; cin>>op;
		cout<<endl;
		switch(op){
			case1:
				cout<<"Ingrese el elemento a insertar: ";cin>>w;
				push(A,tope,w);
			break;
			case2:
				cout<<pop(A,tope);
			break;
			case3:
				imprime(A,tope);
			break;
			default:
				cout<<"Opcion no valida"<<endl;
				break;
		}
		cout<<endl;
		system("pause");
	} while(op !=0);
	/*int tope = -1,w,x,z;
	cout<<"	Ingrese el elemento a insertar: ";cin>>w;
	cout<<"	Ingrese el elemento a insertar: ";cin>>x;
	cout<<"	Ingrese el elemento a insertar: ";cin>>z;
	push(A,tope,w);
	push(A,tope,x);
	push(A,tope,z);
	imprime(A,tope);
	cout<<endl;
	cout<<"Se extrajo: "<<pop(A,tope)<<endl;
	cout<<"Se extrajo: "<<pop(A,tope)<<endl;
	cout<<"Se extrajo: "<<pop(A,tope)<<endl;
	cout<<"Se extrajo: "<<pop(A,tope)<<endl;
	return 0;*/

}
void push(int A[], int &tope, int w){
	if(tope < MAX -1){
		tope++;
		A[tope] = w;
	}
	else{
		cout<<"Desbordamiento"<<endl;
	}
}

int pop(int A[], int &tope);
	int w=0;
	if(tope > -1){
		w=A
	}
	else{
		cout<<"subdesbordamiento"<<endl;
	}


void imprime(int A[], int tope){
	for(int i =0; i <=tope; i++){
		cout<<A[i]<<" ";
		
	}
	
}
