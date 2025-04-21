import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class bloc extends StatefulWidget {
  const bloc({super.key});

  @override
  State<bloc> createState() => _blocState();
}

class _blocState extends State<bloc> {
  final TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather BLoC")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _cityController,
                maxLength: 20,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "City",
                  hintText: "Enter City",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.location_city),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
              onPressed: () {
                final city = _cityController.text.trim();
                if (city.isNotEmpty) {
                  context.read<AllWeather>().add(GetWeather(city: city));
                }
              },
              child: Text("Get Weather",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
            ),
            const SizedBox(height: 20),
            BlocBuilder<AllWeather, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const CircularProgressIndicator();
                } else if (state is WeatherLoaded) {
                  return Text(
                    "Temperature: ${state.temperature}°C",
                      style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.black),
                  );
                } else if (state is WeatherError) {
                  return Text(
                    "Error: ${state.message}",
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return Text("Enter a city and fetch the weather!",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black),);
              },
            ),
          ],
        ),
      ),
    );
  }
}

abstract class WeatherEvent {}

class GetWeather extends WeatherEvent {
  final String city;
  GetWeather({required this.city});
}


abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final double temperature;
  WeatherLoaded(this.temperature);
}

class WeatherError extends WeatherState {
  final String message;
  WeatherError(this.message);
}


class AllWeather extends Bloc<WeatherEvent, WeatherState> {
  AllWeather() : super(WeatherInitial()) {
    on<GetWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final temperature = await WeatherApi.fetch(event.city);
        emit(WeatherLoaded(temperature));
      } catch (e) {
        emit(WeatherError("Failed to fetch weather"));
      }
    });
  }
}


class WeatherApi {
  static Future<double> fetch(String city) async {
    final url = Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=857efc47d0574a968ce113803252103&q=$city&aqi=no');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return (jsonBody['current']['temp_c'] as num).toDouble();
    } else {
      throw Exception('Failed to load weather');
    }
  }
}