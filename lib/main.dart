import 'package:city_weather/features/city_weather/domain/usecases/get_current_weather.dart';
import 'package:city_weather/features/city_weather/presentation/bloc/weather_bloc.dart';
import 'package:city_weather/features/city_weather/presentation/pages/weather_page.dart';
import 'package:city_weather/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<WeatherBloc>(),
        )
      ],
      child: const MaterialApp(
        home: WeatherPage(),
      ),
    );
  }
}
