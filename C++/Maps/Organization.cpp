#include "Person.h"

Organization::Organization(std::string n): name(n), size(0), dim(100) {}

Organization::~Organization() {}

void Organization::addMember(Person* Person) {
    if (size == dim) {
        throw std::out_of_range(getName() + " has already 100 members");
    } else {
        members.insert(make_pair(Person->getName(), Person));
        size++;
    }
}

void Organization::removePerson(Person* person) {
    typedef multimap<string, Person*>::iterator iterator;
    std::pair<iterator, iterator> iterpair = members.equal_range(person->getName());
    
    for (iterator it = iterpair.first; it != iterpair.second; ++it) {
        if (it->second == person) { 
            members.erase(it); 
            size--;
            return;
        }
    }
    
    // Loop skipped, which means Person is not inside of organization
    cout << getName() << " has no memeber " << person->getName() << endl;
}

string Organization::getMemberNames()
{
    std::string name = "";
    for (multimap<string,Person*>::iterator it = members.begin(); it!=members.end(); ++it) {
        name = name + (*it).first + ", ";
    }

    return name;
}


int Organization::getSize() const {
    return size;
}


string Organization::getName() { return name; }



