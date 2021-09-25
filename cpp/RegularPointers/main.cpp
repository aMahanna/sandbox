#include "Person.h"
#include "Organization.h" 
#include "OrganizationPayante.h"

//ajoute une personne a une organisation et une organisation a une personne 
void inscription(Organization* o, Person* p) {
    p->addOrganization(o);
    o->addPerson(*p);
}

//imprime le nom de la personne, le nombre d'organisations de la personne et la liste de nom des organisations de la personne 
void printMembers(Person* person)
{

    cout << person->getName() << " is part of " << person->getSize() << " organisations: " << endl;
    cout << person->getOrgNames() << endl;

}

//main: to test program 
int main() {
    Organization* o0 = new Organization("Math");
    Organization* o1 = new Organization("Test");
    Organization* o2 = new Organization("UofT");
    Organization* o3 = new Organization("UofO");
    Organization* o4 = new Organization("Microsoft");
    Organization* o5 = new Organization("Google");

    OrganizationPayante* o6 = new OrganizationPayante("Subway");
    OrganizationPayante* o7 = new OrganizationPayante("DND");
    o6->setFrais(10); 
    o7->setFrais(30);

    Person* p1 = new Person("Joe");
    Person* p2 = new Person("John");

    inscription(o0, p1);
    inscription(o1, p1);
    inscription(o6, p1);
    inscription(o3, p1);
    inscription(o7, p1);
    //inscription(o5, p1); //throws error 

    inscription(o1, p2);
    inscription(o6, p2);
    inscription(o5, p2);


    printMembers(p1);
    cout << "Paying Organization: \n" << p1->printAPayer() << endl;
    cout << "With annual fees of " << p1->getAPayer() << " $" << endl << endl;


    cout << "----------------------------------------------------------------" << endl;
    printMembers(p2);
    cout << "Paying Organization: \n" << p2->printAPayer() << endl;
    cout << "With annual fees of " << p2->getAPayer() << " $" << endl << endl;
    
    delete p1; 
    delete p2;
    
    delete o1; 
    delete o2; 
    delete o3; 
    delete o4; 
    delete o5; 
    delete o6; 
    delete o7;

    return 0; 

}