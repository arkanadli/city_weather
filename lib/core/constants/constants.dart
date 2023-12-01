class Urls {
  Urls._();

  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = '633cfcf5799d74dd177492b6fcbeb157';
  static String currentWeatherByCityName(String city) {
    return '$baseUrl/weather?q=$city&appid=$apiKey';
  }

  static String weatherIcon(String iconCode) {
    return 'http://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}
