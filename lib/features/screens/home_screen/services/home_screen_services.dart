import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:jo_news/core/constants/app_constants.dart';
import 'package:jo_news/core/networking/dio_helper.dart';
import 'package:jo_news/core/networking/api_endpoints.dart';
import 'package:jo_news/features/screens/home_screen/models/articles_model.dart';

class HomeScreenServices {
  static Future<ArticlesModels> getTopHeadLineArticle() async {
    try {
      final Response response = await DioHelper.getDio(
        endpoint: ApiEndpoints.topHeadLinesEndpoint,
        query: {'country': 'us', 'apiKey': AppConstants.apiKey},
      );
      if (response.statusCode == 200) {
        ArticlesModels topHeadlinesModel = ArticlesModels.fromJson(response.data);
        log(topHeadlinesModel.totalResults.toString());
        return topHeadlinesModel;
      } else {
        throw Exception('statusCode != 200');
      }
    } catch (e) {
      log(e.toString());
      return Future.error(e.toString());
    }
  }
}
