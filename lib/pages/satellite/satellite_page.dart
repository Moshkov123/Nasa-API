import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../api/apiKey.dart';
import '../../design/dimensions.dart';
import '../../design/widgets/accent_button.dart';
import 'satellite_photo_item.dart';

class SatellitePage extends StatefulWidget {
  const SatellitePage({super.key});

  @override
  _SatellitePageState createState() => _SatellitePageState();
}

class _SatellitePageState extends State<SatellitePage> {
  Future<List<dynamic>>? _future;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _future = _fetchSatellitePhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _article(context),
      ],
    );
  }

  Widget _article(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<dynamic> photos = snapshot.data!;
          return ListView.separated(
            controller: _scrollController,
            itemCount: photos.length + 1, // Добавляем к количеству статей еще один элемент - кнопку
            itemBuilder: (context, index) {
              if (index == photos.length) {
                // Если индекс равен длине списка статей, возвращаем кнопку
                return _updateButton(context);
              } else {
                // Иначе возвращаем статью
                final photo = photos[index];
                return SatellitePhotoItem(
                  imageUrl: photo['url'],
                  title: photo['title'],
                  explanation: photo['explanation'],
                );
              }
            },
            separatorBuilder: (context, index) => const Divider(), // Добавляем разделитель между статьями
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        // By default, show a loading spinner
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _updateButton(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: padding16, right: padding16, bottom: padding16),
        child: AccentButton(
          title: 'Обновить',
          onTap: () {
            setState(() {
              _future = _fetchSatellitePhotos();
            });
            _scrollController.animateTo(
              0.0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOut,
            );
          },
        ),
      ),
    );
  }


  Future<List<dynamic>> _fetchSatellitePhotos() async {
    const String url = 'https://api.nasa.gov/planetary/apod?api_key=$ApiKey&count=8';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load photos');
    }
  }
}