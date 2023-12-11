import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageDetailsScreen extends StatelessWidget {
  final String imageUrl;
  final String tags;
  final int downloads;
  final int views;
  final int likes;

  const ImageDetailsScreen({
    super.key,
    required this.imageUrl,
    required this.tags,
    required this.downloads,
    required this.views,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Details'),
      ),
      body: Column(
        children: [
          Hero(
            tag: tags,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
          _buildIconText(Icons.file_download, '$downloads Downloads'),
          _buildIconText(Icons.remove_red_eye, '$views Views'),
          _buildIconText(Icons.thumb_up, '$likes Likes'),
        ],
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
