
#include "Person.h"
#include "OrganizationPayante.h"
#include "Organization.h"
#include "PList.h"

class Organization;

Person::Person(std::string n, int a) {
    name = n;
    age = a;
    organizations = PList<Organization>(5);
};

Person::Person(const Person& registered) {
    name = registered.name;
    age = registered.age;
    organizations = registered.organizations; // Calls PList '=' operand overload
}

Person::~Person()
{
  // This will call ~PList()
}

void Person::addOrganization(Organization* organization) {
    try {
        organizations.add(organization);
    } catch (const out_of_range& e) {
        cout << "Error: Cannot add " << name << " to " << organization->getName() << " - ";
        cout << name << " is enrolled in 5 organizations already.\n" << endl; 
    } 
}

void Person::removeOrganization(Organization* organization) {
    bool success = organizations.rem(organization);
    
    if (!success) {
        cout << "Error Person::removeOrganizaton: Cannot withdraw " << name << " from " << organization->getName() << " - ";
        cout << name << " is not a member of this organization." << endl; 
    } 
}

int Person::getage() { return age; }
std::string Person::getName() { return name; }

int Person::getSize() const {
    return organizations.getSize();
}

int Person::getDim() const {
    return organizations.getCapacity();;
}

// NOTE: Method 'getOrg(int i)' is no longer a const because method getItem() modifies the PList "current" index of this object
Organization* Person::getOrg(int i) {
    return organizations.getItem(i);
}

string Person::getOrgNames() {
    std::string name = "";

    for (int i = 0; i < getSize(); i++)
    {
        name = name + organizations.getItem(i)->getName() + ", "; 
    }
    
    // The code above isn't effective, but it follows the constraints of the assignment 
    // Ideally we could have done something like the following, but these functions are private:
    /* 
        organizations.start(); 
        while (organizations.!isLast()) {
            name = name + organizations.get()->getName() + ", ";
            next(); 
        }
    */ 
    
    return name;
}

float Person::getAPayer() {
    float total = 0;
    
    for (int i = 0; i < getSize(); i++) {
        
        OrganizationPayante* op = dynamic_cast<OrganizationPayante*>(organizations.getItem(i));

        if (op != nullptr) {
            total += op->getFrais();
        }
    }
    // See comments in getOrgNames() about optimization
    
    return total;
}

string Person::printAPayer() {
    string name = "";
    
    for (int i = 0; i < Person::getSize(); i++) {
        
        OrganizationPayante* op = dynamic_cast<OrganizationPayante*>(organizations.getItem(i));

        if (op != nullptr) {
            name = name + op->getName() + ": " + to_string(op->getFrais()) + "; ";

        }
    }
    // See comments in getOrgNames() about optimization
    
    return name;
}



