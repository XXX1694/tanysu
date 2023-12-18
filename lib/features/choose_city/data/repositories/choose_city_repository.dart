import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tanysu/common/constants/constants.dart';
import 'package:tanysu/features/choose_city/data/models/city.dart';

class ChooseCityRepository {
  getCitys() async {
    final url = mainUrl;
    String finalUrl = '${url}locations/countries/';
    final dio = Dio();
    Uri? uri = Uri.tryParse(finalUrl);
    if (uri != null) {
      try {
        final response = await dio.get(finalUrl);
        List<dynamic> a = response.data[0]['cities'];
        List<CityModel> cities = [];
        for (int i = 0; i < a.length; i++) {
          CityModel model = CityModel.fromJson(a[i]);
          cities.add(model);
        }
        if (response.statusCode == 200) {
          return cities;
        } else {
          return 400;
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }
}
