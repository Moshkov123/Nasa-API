import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:satellite/design/styles.dart';
import '../../design/images.dart';
import '../../design/logic/imageLogic.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart' as path;




class RoverPhotoItem extends StatelessWidget {
  final String imageUrl;
  final String roverName;
  final String earthDate;

  const RoverPhotoItem({
    Key? key,
    required this.imageUrl,
    required this.roverName,
    required this.earthDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size adjustedScreenSize = ScreenUtil.calculateAdjustedScreenSize(context);
    return Card(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _showImageDialog(context, imageUrl),
            child: Image.network(
              imageUrl,
              width: adjustedScreenSize.width,
              height: adjustedScreenSize.height,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roverName,
                  style: primaryTextStyle,
                ),
                Text(
                  earthDate,
                  style: hint1TextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _downloadImage(BuildContext context, String url, String imageName) async {
    var status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission is required to download images.')),
      );
      return;
    }
    // Proceed with the download
    var file = await DefaultCacheManager().getSingleFile(url);
    final savedDir = await getDownloadsDirectory();
    final savedImage = await file.copy('${savedDir?.path}/$imageName.jpg');
    print('Image saved at: ${savedImage.path}');

    // Notify the user that the image has been downloaded
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image downloaded successfully.')),
    );
  }
  void _showImageDialog(BuildContext context, String imageUrl) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    double adjustedScreenWidth;
    double adjustedScreenHeight;

    if (screenWidth < screenHeight) {
      // Device is in portrait mode, make the image take up the full width
      adjustedScreenWidth = screenWidth;
      adjustedScreenHeight = screenHeight * 0.35; // 35% of the screen height
    } else {
      // Device is in landscape mode, make the image 35% of the screen width
      adjustedScreenWidth = screenWidth*0.95;
      adjustedScreenHeight = screenHeight*0.75; // Full screen height
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero, // Remove the default padding
          child: Stack(
            children: [
              Container(
                width: adjustedScreenWidth, // Set the width of the container to match the adjusted screen width
                child: Image.network(
                  imageUrl,
                  width: adjustedScreenWidth, // Set the width of the image to match the adjusted screen width
                  height: adjustedScreenHeight, // Set the height of the image to the adjusted screen height
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: IconButton(
                  icon: downloadImage , // Use the file download icon
                  onPressed: () => _downloadImage(context, imageUrl, 'image_name'),
                ),
              ),
            ],
          ),
        );
      },
    );

  }
}
