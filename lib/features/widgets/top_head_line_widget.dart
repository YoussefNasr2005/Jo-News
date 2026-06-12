import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jo_news/core/constants/app_constants.dart';
import 'package:jo_news/core/styles/app_text_styles.dart';
import 'package:jo_news/features/screens/home_screen/article_details_screen.dart';
import 'package:jo_news/features/screens/home_screen/models/articles_model.dart';

class TopHeadLineWidget extends StatelessWidget {
  final Article article;

  const TopHeadLineWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final imageUrl = article.safeImage(article.urlToImage);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ArticleDetailsScreen(article: article),
          ),
        );
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) {
                debugPrint('Image load failed: $error');
                return Image.network(
                  AppConstants.defaultImage,
                  fit: BoxFit.cover,
                );
              },
              height: 206.h,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: 16.h),

          Align(
            alignment: Alignment.topLeft,
            child: Text(
              article.title ?? '',
              style: AppTextStyles.interSemiBold18,
            ),
          ),

          SizedBox(height: 12.h),

          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '${article.author ?? ''}  ${article.safeDate}',
              style: AppTextStyles.interRegular12,
            ),
          ),
        ],
      ),
    );
  }
}
