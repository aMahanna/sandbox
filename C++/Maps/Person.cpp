#include "Person.h"
#include "OrganizationPayante.h"

Person::Person(std::string n, int a): name(n), age(a), size(0) {}

Person::~Person() {}

void Person::addOrganization(Organization* organization) {
    organizations.insert(make_pair(organization->getName(), organization));
    size++;
}

void Person::removeOrganization(Organization* organization) {
    std::map<string,Organization*>::iterator it = organizations.find(organization->getName());
    if (it == organizations.end()) {
        cout << getName() << " is not a part of " << organization->getName() << endl;
    } else {
        organizations.erase(it);
        size--;
    }
}


std::string Person::getName() { return name; }


int Person::getSize() const {return size;}


string Person::getOrgNames() {
    std::string name = "";
    for (map<string,Organization*>::iterator it = organizations.begin(); it!=organizations.end(); ++it) {
        name = name + (*it).first + ", ";
    }
        
    return name;
}

float Person::getAPayer() {
    float total = 0;
    for (map<string,Organization*>::iterator it = organizations.begin(); it!=organizations.end(); ++it) {
        OrganizationPayante* op = dynamic_cast<OrganizationPayante*>((*it).second);
        
        if (op != nullptr) {
            total += op->getFrais();
        }
    }
    
    return total;
}

string Person::printAPayer() {
    string name = "";
    for (map<string,Organization*>::iterator it = organizations.begin(); it!=organizations.end(); ++it) {
        OrganizationPayante* op = dynamic_cast<OrganizationPayante*>((*it).second);
        
        if (op != nullptr) {
            name = name + op->getName() + ": " + to_string(op->getFrais()) + "; ";

        }
    }
    
    return name;
}



