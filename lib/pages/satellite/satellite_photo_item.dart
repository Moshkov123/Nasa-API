import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:satellite/design/dimensions.dart';
import 'package:satellite/design/styles.dart';
import '../../design/images.dart';
import '../../design/logic/imageLogic.dart';
import 'package:sqflite/sqflite.dart';

class SatellitePhotoItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String explanation;
  final Function(String, String, String) insertDataCallback;

  const SatellitePhotoItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.explanation,
    required this.insertDataCallback,
  }) : super(key: key);

  @override
  _SatellitePhotoItemState createState() => _SatellitePhotoItemState();
}

class _SatellitePhotoItemState extends State<SatellitePhotoItem> {
  late Database database;
  final String tableName = 'articles_table';

  @override
  void initState() {
    super.initState();
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'articles_database.db'); // Use a different name for the database
    database = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          imageUrl TEXT,
          explanation TEXT
        )
      ''');
    });
  }
  Future<void> insertData(String title, String imageUrl, String explanation) async {
    // Check if the article already exists in the database
    List<Map<String, dynamic>> existingArticles = await database.query(
      tableName,
      where: 'title = ? AND imageUrl = ?',
      whereArgs: [title, imageUrl],
      limit: 1, // Limit to 1 to avoid unnecessary queries
    );

    if (existingArticles.isNotEmpty) {
      // Article already exists, do not insert
      print('Article with title "$title" and imageUrl "$imageUrl" already exists in the database.');
      return;
    }

    // Article does not exist, insert it
    await database.insert(tableName, {
      'title': title,
      'imageUrl': imageUrl,
      'explanation': explanation
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteData(String imageUrl) async {
    try {
      await database.delete(tableName, where: 'imageUrl = ?', whereArgs: [imageUrl]);
      print('Data with imageUrl: $imageUrl deleted from the database');
    } catch (e) {
      print('Failed to delete data from the database: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size adjustedScreenSize = ScreenUtil.calculateAdjustedScreenSize(context);
    return Card(
      child: Column(
        children: [
          Image.network(
            widget.imageUrl,
            width: adjustedScreenSize.width,
            height: adjustedScreenSize.height,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(padding8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: primaryTextStyle,
                ),
                Text(
                  widget.explanation,
                  style: hint1TextStyle,
                ),
              ],
            ),
          ),
          _conditionButton(context),
        ],
      ),
    );
  }
  bool isSaved = false; // Track the state of the article

  Widget _conditionButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (isSaved) {
          // Delete the article and change the image to conditionImage
          deleteData(widget.imageUrl);
          setState(() {
            isSaved = false;
          });
        } else {
          // Save the article and change the image to starImage
          insertData(widget.title, widget.imageUrl, widget.explanation);
          setState(() {
            isSaved = true;
          });
        }
      },
      icon: isSaved ? starImage : conditionImage,
    );
  }
}
