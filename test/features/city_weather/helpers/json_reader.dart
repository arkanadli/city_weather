import 'dart:io';

String readJson(String fileName) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir\\test\\features\\city_weather\\$fileName')
      .readAsStringSync();
}
// C:\Arkan\arkan\Dart\city_weather\test\features\city_weather\helpers\dummy_data\dummy_weather_response.json
