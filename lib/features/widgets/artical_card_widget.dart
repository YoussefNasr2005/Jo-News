import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_news/core/constants/app_constants.dart';
import 'package:jo_news/core/styles/app_text_styles.dart';
import 'package:jo_news/features/screens/home_screen/article_details_screen.dart';
import 'package:jo_news/features/screens/home_screen/models/articles_model.dart';

class ArticleCardWidget extends StatelessWidget {
  final Article article;

  const ArticleCardWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.h),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ArticleDetailsScreen(article: article),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      article.title ?? '',
                      maxLines: 2,
                      style: AppTextStyles.interSemiBold18,
                    ),
                  ),

                  SizedBox(height: 4.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${article.author ?? ''}  ${article.safeDate}',
                      style: AppTextStyles.interRegular12,
                    ),
                  ),
                ],
              ),
            ),

            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),

              child: CachedNetworkImage(
                imageUrl: article.safeImage(article.urlToImage),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) {
                  debugPrint('Image load failed: $error');
                  return Image.network(
                    AppConstants.defaultImage,
                    fit: BoxFit.cover,
                  );
                },
                height: 80.h,
                width: 112.w,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
