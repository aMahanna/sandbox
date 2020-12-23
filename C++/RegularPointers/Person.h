#ifndef PERSON_H 
#define PERSON_H 


#include <iostream>
#include <string>
#include <stdlib.h>
using namespace std;

class Organization;
class OrganizationPayante;

class Person {

    string name;
    int age;
    int size;
    Organization *orgPointers[5];
  

public:

    Person(string n = "default", int a = rand() % 30 + 16);

    // Exception lancée si size > 5
    void addOrganization(Organization* organization);
    
    float getAPayer(); 
    string printAPayer(); 
    string getOrgNames(); 
    
    string getName();
    int getAge();
    int getSize();
    
};

#endif