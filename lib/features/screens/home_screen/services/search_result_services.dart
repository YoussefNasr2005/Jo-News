import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jo_news/core/constants/app_constants.dart';
import 'package:jo_news/core/networking/api_endpoints.dart';
import 'package:jo_news/core/networking/dio_helper.dart';
import 'package:jo_news/features/screens/home_screen/models/articles_model.dart';

class SearchResultServices {
  static Future<ArticlesModels> searchItemByName(String query) async {
    try {
      final Response response = await DioHelper.getDio(
        endpoint: ApiEndpoints.searchEndpoint,
        query: {
          'apiKey': AppConstants.apiKey,
          'q': query,
          'language': AppConstants.currentLang,
        },
      );
      if (response.statusCode == 200) {
        ArticlesModels searchModelResult = ArticlesModels.fromJson(response.data);
        log(searchModelResult.totalResults.toString());
        return searchModelResult;
      } else {
        throw Exception('response.statusCode != 200');
      }
    } catch (e) {
      log(e.toString());
      return Future.error(e.toString());
    }
  }
}
