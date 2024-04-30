import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:satellite/design/colors.dart';
import 'package:satellite/design/images.dart';
import 'package:satellite/design/styles.dart';
import '../../api/apiKey.dart';
import 'rover_photo_item.dart';

class RoverPage extends StatelessWidget {
  final String roverName;

  const RoverPage({super.key, required this.roverName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$roverName Photos',
          style: primaryTextStyle,
        ),
        centerTitle: true,
        backgroundColor: SurfacevColor,
        leading: IconButton(
          icon: arrowImage,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchRoverPhotos(roverName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> photos = snapshot.data!;
            return ListView.builder(
              itemCount: photos.length,
              itemBuilder: (context, index) {
                final photo = photos[index];
                return RoverPhotoItem(
                  imageUrl: photo['img_src'],
                  roverName: roverName,
                  earthDate: photo['earth_date'],
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

  Future<List<dynamic>> _fetchRoverPhotos(String roverName) async {
    final String url = 'https://api.nasa.gov/mars-photos/api/v1/rovers/${roverName.toLowerCase()}/photos?sol=1000&api_key=$ApiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['photos'];
    } else {
      throw Exception('Failed to load photos');
    }
  }
}