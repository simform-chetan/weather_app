enum ForecastUnit {
  celsius(0),
  fahrenheit(1);

  const ForecastUnit(this.position);

  final int position;

  double fromKelvin(double kelvin) {
    final offset = kelvin - 273.15;
    return switch (this) {
      celsius => offset,
      fahrenheit => offset * 9 / 5 + 32,
    };
  }

  static ForecastUnit fromPosition(int pos) {
    return switch (pos) {
      _ when pos == fahrenheit.position => fahrenheit,
      _ => celsius,
    };
  }
}

enum UpdateInterval {
  ten(0, 10),
  fifteen(1, 15),
  thirty(2, 30),
  sixty(3, 60);

  const UpdateInterval(this.position, this.minutes);

  final int position;
  final int minutes;

  bool isPastInterval(DateTime time) {
    return false;
  }

  static UpdateInterval fromPosition(int pos) {
    pos = pos % (sixty.position+1);
    return switch (pos) {
      _ when pos == ten.position => ten,
      _ when pos == fifteen.position => fifteen,
      _ when pos == thirty.position => thirty,
      _ => sixty,
    };
  }
}
