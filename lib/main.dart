import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/views/home_view.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GetWeatherCubit(),
        child: Builder(builder: (context) {
          return BlocBuilder<GetWeatherCubit, WeatherState>(
            builder: (context, state) {
              final condition = state is WeatherLoadedState
                  ? state.weatherModel.weatherCondition
                  : null;
              return MaterialApp(
                home: const HomeView(),
                theme: ThemeData(
                    primarySwatch: getThemeColor(condition),
                    appBarTheme: AppBarTheme(
                      backgroundColor: getThemeColor(condition),
                      foregroundColor: Colors.white,
                    )),
              );
            },
          );
        }));
  }
}

MaterialColor getThemeColor(String? condition) {
  if (condition == null) {
    return Colors.blue;
  }
  switch (condition) {
    case 'Sunny':
      return Colors.orange;

    case 'Clear':
      return Colors.deepOrange;

    case 'Partly cloudy':
      return Colors.blueGrey;

    case 'Cloudy':
    case 'Overcast':
      return Colors.grey;

    case 'Mist':
    case 'Fog':
    case 'Freezing fog':
      return Colors.blueGrey;

    case 'Light rain':
    case 'Patchy light rain':
    case 'Moderate rain':
    case 'Heavy rain':
    case 'Light rain shower':
    case 'Torrential rain shower':
      return Colors.indigo;

    case 'Light snow':
    case 'Moderate snow':
    case 'Heavy snow':
    case 'Blizzard':
      return Colors.lightBlue;

    case 'Thundery outbreaks possible':
    case 'Moderate or heavy rain with thunder':
      return Colors.deepPurple;

    default:
      return Colors.blue;
  }
}
