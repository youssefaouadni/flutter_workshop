import 'package:dio/dio.dart';

import '../models/images_model.dart';

abstract class ImageService {
  static Future<ImagesModel> getImages(String searchKeyword) async {
    Response response = await Dio().get(
        'https://pixabay.com/api/?key=23839781-aabf31afc5521ef394b0da263&q=$searchKeyword&image_type=photo');
    return ImagesModel.fromJson(response.data);
  }
}
