#ifndef ORGANIZATION_H 
#define ORGANIZATION_H 

#include <iostream>
#include <string>
#include <stdlib.h>
using namespace std;

//entrer déclaration de classe
class Person;

class Organization {

    string name; // name of the org
    Person* members; // list of members
    int size;  // actual size of the org
    int dim;  // max size of the org


public:
    Organization(string n = "default");
    Organization(const Organization& organization);
    ~Organization();

    // return the name of all members entolled in the organization
    // all members written in onre string separated by semi-colons
    // returns empty string if no member is enrolled in the organization
    virtual string getMemberNames(); 
    
    // adds a Person to the members array of the organization
    // Should double the members array size if array is full
    virtual void addPerson(Person person); 
    
    virtual string getName() const; 
    virtual int getSize() const; 
    virtual int getDim() const; 
};

#endif // ORGANIZATION_H