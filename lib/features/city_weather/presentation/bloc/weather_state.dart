import 'package:city_weather/features/city_weather/domain/entities/weather.dart';
import 'package:equatable/equatable.dart';

class WeatherState extends Equatable {
  const WeatherState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity result;
  const WeatherLoaded(this.result);

  @override
  // TODO: implement props
  List<Object?> get props => [result];
}

class WeatherLoadFailure extends WeatherState {
  final String errorMessage;

  const WeatherLoadFailure({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
