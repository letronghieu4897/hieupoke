double feetToMeter(double feet) {
  if (feet != null) return feet * 30.48;
  return 0;
}

double lbsToKilo(double lbs) {
  if (lbs != null) return lbs * 0.453592;
  return 0;
}

double formatHeightWidth(double value) {
  if (value != null) return value / 10;
  return 0;
}
