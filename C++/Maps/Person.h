#ifndef Person_H_
#define Person_H_
#include "Organization.h"

#include <string>
#include <map>

using namespace std;

class Person {

    std::string name;
    int age;
    std::map<string,Organization*> organizations;
    int size;

public:

    Person(std::string n = "default", int a = rand() % 30 + 16);
    ~Person();
    void addOrganization(Organization* organization);
    void removeOrganization(Organization* organization);
    float getAPayer();
    string printAPayer();
    string getOrgNames();
    int getSize() const;
    std::string getName();
};


#endif 