import 'package:city_weather/features/city_weather/domain/usecases/get_current_weather.dart';
import 'package:city_weather/features/city_weather/presentation/bloc/weather_event.dart';
import 'package:city_weather/features/city_weather/presentation/bloc/weather_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnCityChanged>(
      (event, emit) async {
        // when user starting changing the cityname in the ui field, it will trigger this
        // firstly we want to set the state is in Loading State
        emit(WeatherLoading());

        // Start Fetching from the api
        final result = await _getCurrentWeatherUseCase.execute(event.cityName);

        result.fold((failure) {
          emit(WeatherLoadFailure(errorMessage: failure.message));
        }, (data) {
          emit(WeatherLoaded(data));
        });
      },
      transformer: debouce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debouce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}
