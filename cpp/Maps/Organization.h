#ifndef OrganizationH
#define OrganizationH 

#include <iostream>
#include <string>
#include <stdlib.h>
#include <map>
using namespace std;

class Person;

class Organization {
    string name;
    std ::multimap<string,Person*> members;
    int dim;
    int size;

public:

    Organization(std::string n = "default");
    virtual ~Organization();
    void addMember(Person* members);
    void removePerson(Person* members);
    string getMemberNames();
    string getName();
    int getSize() const;


};

#endif 