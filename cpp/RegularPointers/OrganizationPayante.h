#ifndef ORGANIZATIONP_H
#define ORGANIZATIONP_H

#include <iostream>
#include <string>
#include <stdlib.h>
#include "Organization.h"
using namespace std;

class OrganizationPayante : public Organization {
    float fraisAnnuel;

public:
    OrganizationPayante(std::string n = "default");
    
    OrganizationPayante(const OrganizationPayante& op);
    
    ~OrganizationPayante();
    
    float getFrais(); 
    void setFrais(float f);
};

#endif // ORGANIZATIONP_H
