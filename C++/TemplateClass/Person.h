#ifndef Person_H_
#define Person_H_
#include "Organization.h"
#include "PList.h"

class Organization;

class Person {

    std::string name;   
    int age;    
    PList<Organization> organizations;

public:

    Person(std::string n = "default", int a = rand() % 30 + 16);
    Person(const Person& registered); 
    ~Person();
    string getOrgNames();
    void addOrganization(Organization* organization);
    void removeOrganization(Organization* organization); 
    int getSize() const;
    // NOTE: Method 'getOrg(int i)' is no longer a const because method getItem() modifies the PList "current" index of this object
    Organization* getOrg(int i); 
    int getage();
    std::string getName();
    int getDim() const;
    float getAPayer();
    string printAPayer();
};


#endif 