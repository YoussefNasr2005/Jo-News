import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_news/core/styles/app_text_styles.dart';
import 'package:jo_news/features/screens/home_screen/models/articles_model.dart';

class ArticleDetailsScreen extends StatelessWidget {
  const ArticleDetailsScreen({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            CachedNetworkImage(
              width: 430.w,
              height: 361.h,
              imageUrl: article.safeImage(article.urlToImage),
              fit: BoxFit.cover,
            ),

            Positioned(
              top: 300.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r),
                  ),
                ),

                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),

                      Text(
                        article.title ?? '',
                        style: AppTextStyles.interSemiBold18,
                      ),

                      SizedBox(height: 16.h),

                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '${article.author ?? ''}  ${article.safeDate}',
                          style: AppTextStyles.interRegular12,
                        ),
                      ),
                      SizedBox(height: 24.h),

                      Text(
                        article.description ?? '',
                        style: AppTextStyles.merriweatherRegular16,
                      ),

                      SizedBox(height: 5.h),

                      Text(
                        article.content ?? '',
                        style: AppTextStyles.merriweatherRegular16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
