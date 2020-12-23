#include "OrganizationPayante.h" 
#include "Organization.h" 
#include <math.h>

class Organization;

OrganizationPayante::OrganizationPayante(std::string n) : Organization(n), fraisAnnuel(0.0) {}

OrganizationPayante::OrganizationPayante(const OrganizationPayante& op) : Organization(op), fraisAnnuel(op.fraisAnnuel) {}

OrganizationPayante::~OrganizationPayante() {}

void OrganizationPayante::setFrais(float f) {
    fraisAnnuel = f;
}
float OrganizationPayante::getFrais() { return fraisAnnuel; }


