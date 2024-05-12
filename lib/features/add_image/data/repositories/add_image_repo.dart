import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/core/constants/constants.dart';

final _storage = SharedPreferences.getInstance();

class AddImageRepository {
  addImage({
    required String image,
    required int profileId,
  }) async {
    final url = mainUrl;
    String finalUrl = '${url}profile/image/save/';
    final dio = Dio();

    try {
      FormData formData = FormData.fromMap({
        "profile": profileId,
        "image": await MultipartFile.fromFile(image, filename: image),
      });
      final response = await dio.post(
        finalUrl,
        data: formData,
      );
      if (response.statusCode == 201) {
        return 201;
      } else {
        return 400;
      }
    } catch (e) {
      return 400;
    }
  }

  delete({
    required int imageId,
  }) async {
    final storage = await _storage;
    final url = mainUrl;
    String finalUrl = '${url}profile/image/delete/$imageId/';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";

    try {
      final response = await dio.delete(
        finalUrl,
      );
      if (response.statusCode == 204) {
        return 201;
      } else {
        return 400;
      }
    } catch (e) {
      return 400;
    }
  }

  change({
    required int imageId,
    required String imageUrl,
  }) async {
    final storage = await _storage;
    final url = mainUrl;
    String finalUrl = '${url}profile/image/update/$imageId/';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    FormData formData = FormData.fromMap({
      "id": imageId,
      "image": await MultipartFile.fromFile(imageUrl, filename: imageUrl),
    });

    try {
      final response = await dio.put(
        finalUrl,
        data: formData,
      );
      if (response.statusCode == 200) {
        return 201;
      } else {
        return 400;
      }
    } catch (e) {
      return 400;
    }
  }
}
