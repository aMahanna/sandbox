
#ifndef OrganizationH
#define OrganizationH 

#include "PList.h"
#include <iostream>
#include <string>
#include <stdlib.h>

using namespace std;
class Person;

class Organization {
    string name;
    PList<Person> members;

public:

    Organization(std::string n = "default");
    Organization(const Organization& registered); 
    virtual ~Organization();
    void addMember(Person* person);
    void removeMember(Person* person);
    int getSize() const;
    int getDim() const;
    // NOTE: Method 'getPersons(int i)' is no longer a 'const' because method getItem() modifies the PList "current" index of this object
    Person* getPersons(int i);

    string getName();
};

#endif 