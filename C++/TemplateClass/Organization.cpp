
#include "Person.h"
#include "PList.h"

Organization::Organization(std::string n) {
    name = n;
    members = PList<Person>(100);
};

Organization::Organization(const Organization& registered)
{
    name = registered.name;
    members = registered.members; // Calls PList '=' operand overload
}

Organization::~Organization()
{
    // This will call ~PList()
}

void Organization::addMember(Person* person) {
    try {
        members.add(person);
    } catch (const out_of_range& e) {
        cout << "Error: Cannot add " << person->getName() << " to " << name << " - ";
        cout << name << " has already 100 members.\n" << endl; 
    } 
}

void Organization::removeMember(Person* person) {
    bool success = members.rem(person);
    
    if (!success) {
        cout << "Error Organization::removeMember: Cannot withdraw " << person->getName() << " from " << name << " - ";
        cout << name << " doesn't have this member in its organization.\n" << endl; 
    } 
}

int Organization::getSize() const {
    return members.getSize();
}

int Organization::getDim() const {
    return members.getCapacity();
}

// NOTE: Method 'getPersons(int i)' is no longer a 'const' because method getItem() modifies the PList "current" index of this object
Person* Organization::getPersons(int i) {
    return members.getItem(i);
}

string Organization::getName() { return name; }



