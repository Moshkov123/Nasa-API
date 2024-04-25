import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../api/apiKey.dart';
import 'satellite_photo_item.dart';

class SatellitePage extends StatelessWidget {
  const SatellitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _fetchSatellitePhotos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> photos = snapshot.data!;
            return ListView.builder(
              itemCount: photos.length,
              itemBuilder: (context, index) {
                final photo = photos[index];
                return SatellitePhotoItem(
                  imageUrl: photo['url'],
                  title: photo['title'],
                  explanation: photo['explanation'],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // By default, show a loading spinner
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<dynamic>> _fetchSatellitePhotos() async {
    final String url = 'https://api.nasa.gov/planetary/apod?api_key=$ApiKey&count=40';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load photos');
    }
  }
}