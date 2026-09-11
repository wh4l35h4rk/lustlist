enum ScaleValue {
  xsm(0.75, "75%"),
  sm(0.9, "90%"),
  def(1, "100%"),
  lg(1.1, "110%"),
  xlg(1.25, "125%");

  const ScaleValue(this.value, this.label);

  final double value;
  final String label;
}