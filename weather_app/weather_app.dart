import 'dart:convert';
import 'dart:io';
import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http;

var env = DotEnv(includePlatformEnvironment: true)..load();

String apiKey = env['OPEN_WEATHER_MAP'] ?? '';

class Weather {
  final String cityName;
  final double temperatureCelsius;
  final String condition;
  final String description;

  Weather({
    required this.cityName,
    required this.temperatureCelsius,
    required this.condition,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temperatureCelsius: json['main']['temp'] - 273.15,
        condition: json['weather'][0]['main'],
        description: json['weather'][0]['description']);
  }
}

Future<Weather> getWeather(String cityName) async {
  final url = Uri.parse(
      'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Weather.fromJson(jsonData);
    } else {
      throw Exception(
          'Gagal mendapatkan data cuaca: Kota tidak ditemukan atau terjadi error.');
    }
  } catch (e) {
    throw Exception(
        'Gagal terhubung ke server. Periksa koneksi internet Anda.');
  }
}

void main() async {
  print('--- Weather App ---');

  while (true) {
    stdout.write('Masukkan nama kota (atau ketik "exit" untuk keluar): ');
    String city = stdin.readLineSync()!.trim();

    if (city.toLowerCase() == 'exit') {
      print('--- Bye ---');
      break;
    }

    if (city.isEmpty) {
      print('Nama kota tidak boleh kosong.');
      continue;
    }

    try {
      print('Mencari data untuk kota $city...');
      final weather = await getWeather(city);

      print('\n--- Cuaca Saat Ini di ${weather.cityName} ---');
      print('Suhu: ${weather.temperatureCelsius.toStringAsFixed(1)}\u00B0C');
      print('Kondisi: ${weather.condition} (${weather.description})');
      print('--- Selesai ---');
    } catch (e) {
      print('Error: ${e.toString().replaceAll("Exception: ", "")}\n');
    }
  }
}
