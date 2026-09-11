enum ScaleValue {
  xsm(0.7, "70%"),
  sm(0.85, "85%"),
  def(1, "100%"),
  lg(1.15, "115%"),
  xlg(1.3, "130%");

  const ScaleValue(this.value, this.label);

  final double value;
  final String label;
}