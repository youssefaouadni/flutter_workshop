import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_workshop/screens/image_details_screen.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final String tags;
  final int downloads;
  final int views;
  final int likes;

  const ImageWidget({
    super.key,
    required this.imageUrl,
    required this.tags,
    required this.downloads,
    required this.views,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageDetailsScreen(
              imageUrl: imageUrl,
              downloads: downloads,
              likes: likes,
              tags: tags,
              views: views,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5.0,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Hero(
                tag: tags,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).highlightColor, width: 2.0),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        'Tags: $tags',
                        maxLines: 2,
                        style: const TextStyle(fontSize: 16.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    _buildIconText(
                        Icons.file_download, '$downloads Downloads'),
                    _buildIconText(Icons.remove_red_eye, '$views Views'),
                    _buildIconText(Icons.thumb_up, '$likes Likes'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 30.0),
        const SizedBox(width: 8.0),
        Text(text),
      ],
    );
  }
}
