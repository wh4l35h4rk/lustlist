class RatingController {
  int? value;

  RatingController({
    this.value = 0
  });

  void setRating(int? newValue) {
    value = newValue;
  }
}