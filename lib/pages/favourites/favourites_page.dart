import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../design/images.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late Database database;
  final String tableName = 'articles_table';
  List<Map<String, dynamic>> articles = []; // List to hold articles

  @override
  void initState() {
    super.initState();
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'articles_database.db');
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
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    List<Map<String, dynamic>> result = await database.query(tableName);
    setState(() {
      articles = result;
    });
  }

  Future<void> deleteArticle(String imageUrl, String title) async {
    // Find the article by imageUrl and title and delete it
    await database.delete(
      tableName,
      where: 'imageUrl = ? AND title = ?',
      whereArgs: [imageUrl, title],
    );
    fetchArticles(); // Refresh the list of articles after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return SatellitePhotoItem(
            imageUrl: article['imageUrl'],
            title: article['title'],
            explanation: article['explanation'],
            onDelete: () {
              deleteArticle(article['imageUrl'], article['title']);
            },
          );
        },
      ),
    );
  }
}

// SatellitePhotoItem widget should be updated to handle the onDelete callback
class SatellitePhotoItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String explanation;
  final VoidCallback onDelete;

  const SatellitePhotoItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.explanation,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size adjustedScreenSize = MediaQuery.of(context).size;
    return Card(
      child: Column(
        children: [
          Image.network(
            imageUrl,
            width: adjustedScreenSize.width,
            height: adjustedScreenSize.height * 0.3,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  explanation,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: starImage,
          ),
        ],
      ),
    );
  }
}