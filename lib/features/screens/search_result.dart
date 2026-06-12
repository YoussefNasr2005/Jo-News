import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_news/core/styles/app_colors.dart';
import 'package:jo_news/core/styles/app_text_styles.dart';
import 'package:jo_news/features/screens/home_screen/services/search_result_services.dart';
import 'package:jo_news/features/widgets/artical_card_widget.dart';

import '../../core/constants/app_constants.dart';

class SearchResult extends StatefulWidget {
  final String topicName;
  const SearchResult({super.key, required this.topicName});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.secondryColor,
        title: Text(
          'search_results'.tr(),
          style: AppTextStyles.interSemiBold18,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
              if (context.locale.languageCode == 'ar') {
                context.setLocale(const Locale('en'));
              } else {
                context.setLocale(const Locale('ar'));
              }
              AppConstants.currentLang = context.locale.languageCode;
            },
            icon: const Icon(Icons.language),
            iconSize: 30.sp,
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),

        child: FutureBuilder(
          future: SearchResultServices.searchItemByName(widget.topicName),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            }

            if (snapshot.hasData) {
              final searchHeadlinesModel = snapshot.data!;
              if (searchHeadlinesModel.totalResults == 0) {
                return Center(
                  child: Text(
                    'no_result',
                    style: AppTextStyles.interSemiBold18,
                  ).tr(),
                );
              }

              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 24.h),

                  Expanded(
                    child: ListView.builder(
                      itemCount: searchHeadlinesModel.articles.length - 1,
                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        final article =
                            searchHeadlinesModel.articles[index + 1];
                        return GestureDetector(
                          onTap: () {},
                          child: ArticleCardWidget(article: article),
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return Center(
              child: Text(
                'Data_do_not_found'.tr(),
                style: AppTextStyles.interSemiBold18,
              ),
            );
          },
        ),
      ),
    );
  }
}
