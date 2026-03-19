enum PartnersAmount {
  onePartner("One partner"),
  severalPartners("2+ partners"),
  unknown("Unknown");

  final String label;

  const PartnersAmount(this.label);
}
