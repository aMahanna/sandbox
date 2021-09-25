#include "Organization.h" 
#include "Person.h" 

Organization::Organization(string n) : name(n), size(0), dim(100) {
    members = new Person[dim];
};

Organization::Organization(const Organization& organization) : name(organization.name), size(organization.size), dim(organization.dim) {
    members = new Person[dim];
    for (int i = 0; i < size; i++) {

        members[i] = organization.members[i];
    }

}

Organization::~Organization() {
    delete[] members;
}

string Organization::getMemberNames() {
    string name ="";
    for (int i = 0; i<size;i++)
    {
        name = name + members[i].getName()+ ":"+ to_string(members[i].getAge()) + "; ";
    }
    return name;
}

void Organization::addPerson(Person person) {
    if( size>= dim)
    {
        Person *tmp= new Person[dim*2];
        for (int i=0; i<size; i++)
        {
            tmp[i]= members[i];
        }
        delete[] members;
        members=tmp;
        dim*= 2;
    }

    members[size++] = person;
}

string Organization::getName() const { return name; }
int Organization::getSize() const { return size; }
int Organization::getDim() const { return dim; }


