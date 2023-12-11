import 'package:flutter/material.dart';
import 'package:flutter_workshop/services/image_service.dart';
import 'package:flutter_workshop/widgets/image_widget.dart';

import '../models/images_model.dart';
import '../widgets/search_widget.dart';

class ImageSearchScreen extends StatefulWidget {
  const ImageSearchScreen({super.key});

  @override
  ImageSearchScreenState createState() => ImageSearchScreenState();
}

class ImageSearchScreenState extends State<ImageSearchScreen> {
  late Future<ImagesModel> _imagesFuture;
  String _searchQuery = '';
  @override
  void initState() {
    super.initState();
    _imagesFuture = _loadImages();
  }

  Future<ImagesModel> _loadImages() async {
    if (_searchQuery.isNotEmpty) {
      return ImageService.getImages(_searchQuery);
    } else {
      // Return a default or initial ImagesModel if no search query
      return ImageService.getImages('yellow+flowers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Search'),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchFieldWidget(
                onChanged: (String query) async{
                  setState(() {
                    _searchQuery = query;
                  });
                  _imagesFuture = _loadImages();
                  await _loadImages();
                },
              )),
          Expanded(
            child: FutureBuilder<ImagesModel>(
              future: _imagesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text('No data available'),
                  );
                } else {
                  // Display the ListView of images here
                  // Use snapshot.data to access the ImagesModel
                  return ListView.builder(
                    itemCount: snapshot.data!.hits!.length,
                    itemBuilder: (context, index) {
                      // Build your list item here
                      return ImageWidget(
                          imageUrl: snapshot.data!.hits![index].previewURL!,
                          tags: snapshot.data!.hits![index].tags!,
                          downloads: snapshot.data!.hits![index].downloads!,
                          views: snapshot.data!.hits![index].views!,
                          likes: snapshot.data!.hits![index].views!);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
