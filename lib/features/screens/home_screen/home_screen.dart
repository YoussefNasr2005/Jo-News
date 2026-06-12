import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_news/core/database/topics_preferences.dart';
import 'package:jo_news/core/styles/app_colors.dart';
import 'package:jo_news/core/styles/app_text_styles.dart';
import 'package:jo_news/features/screens/home_screen/models/articles_model.dart';
import 'package:jo_news/features/screens/home_screen/services/home_screen_services.dart';
import 'package:jo_news/features/screens/search_result.dart';
import 'package:jo_news/features/widgets/artical_card_widget.dart';
import 'package:jo_news/features/widgets/custom_textfield.dart';
import 'package:jo_news/features/widgets/top_head_line_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TextEditingController> topicsControllers = [];
  late Future<ArticlesModels> _articlesFuture;

  @override
  void initState() {
    super.initState();
    // Topicspreferences.cleanPrefs();
    _loadTopics();
    _articlesFuture = HomeScreenServices.getTopHeadLineArticle();
  }

  Future<void> _loadTopics() async {
    final topics = await Topicspreferences.loadTopics();

    if (!mounted) return;

    setState(() {
      topicsControllers = topics
          .map((topic) => TextEditingController(text: topic))
          .toList();
    });
  }

  @override
  void dispose() {
    for (var topic in topicsControllers) {
      topic.dispose();
    }
    super.dispose();
  }

  int selectIndex = 0;
  bool isEditMode = false;
  bool isSearchMode = false;
  @override
  Widget build(BuildContext context) {
    context.locale;
    return Scaffold(
      
      floatingActionButton: _showEditDialog(),

      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearchMode = !isSearchMode;
              });
            },
            icon: const Icon(Icons.search),
            iconSize: 35.sp,
          ),
          SizedBox(width: 10.w),
        ],
        title: isSearchMode == true
            ? CustomTextField(
                fillColor: AppColors.secondryColor,
                width: 308.w,
                textColor: AppColors.primaryColor,
                hintText: 'search'.tr(),
                onSubmitted: (value) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SearchResult(topicName: value),
                    ),
                  );
                },
              )
            : Text(
                'explore'.tr(),
                style: AppTextStyles.interSemiBold18.copyWith(fontSize: 32.sp),
              ),
        backgroundColor: AppColors.secondryColor,
        toolbarHeight: 120.h,
      ),

      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),

      child: FutureBuilder(
        future: _articlesFuture,
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
            final topHeadlinesModel = snapshot.data!;
            if (topHeadlinesModel.totalResults == 0) {
              return Center(
                child: Text(
                  'no_result',
                  style: AppTextStyles.interSemiBold18,
                ).tr(),
              );
            }
            return _showTopicsData(topHeadlinesModel);
          }

          return Center(
            child: Text(
              'Data_do_not_found'.tr(),
              style: AppTextStyles.interSemiBold18,
            ),
          );
        },
      ),
    );
  }

  Widget _firstSection(bool isEditMode) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) =>
            Padding(padding: EdgeInsets.only(right: 12.w)),
        itemCount: topicsControllers.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              selectIndex = index;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SearchResult(topicName: topicsControllers[index].text),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: selectIndex == index
                  ? const Color(0xffE9EEFA)
                  : const Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(56.r),
              border: Border.all(width: 1, color: const Color(0xffE9EEFA)),
            ),
            height: 32.h,
            width: 120.w,
            child: Center(
              child: isEditMode
                  ? TextField(
                      keyboardType: TextInputType.text,
                      controller: topicsControllers[index],
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: AppTextStyles.interSemiBold18.copyWith(
                        fontSize: 14.sp,
                      ),
                    )
                  : Text(
                      topicsControllers[index].text.tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.interSemiBold18.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showTopicsData(ArticlesModels topHeadlinesModel) {
    Article article = topHeadlinesModel.articles[0];
    return Column(
      children: [
        SizedBox(height: 16.h),
        _firstSection(isEditMode),

        SizedBox(height: 18.h),

        TopHeadLineWidget(article: article),

        SizedBox(height: 15.h),

        Expanded(
          child: ListView.builder(
            itemCount: topHeadlinesModel.articles.length - 1,
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              final Article article = topHeadlinesModel.articles[index + 1];
              return ArticleCardWidget(article: article);
            },
          ),
        ),
      ],
    );
  }

  Widget _showEditDialog() {
    return FloatingActionButton(
      onPressed: () {
        AwesomeDialog(
          context: context,
          btnOkText: 'btn_ok'.tr(),
          btnCancelText: 'btn_cancel'.tr(),
          dialogType: DialogType.question,
          animType: AnimType.rightSlide,
          title: isEditMode ? 'dialog_title_edit'.tr() : 'dialog_title'.tr(),
          desc: isEditMode ? 'dialog_des_edit'.tr() : 'dialog_des'.tr(),
          btnCancelOnPress: () {},
          btnOkOnPress: () async {
            if (isEditMode) {
              List<String> toListString = topicsControllers.map((topic) {
                if (topic.text.trim().isEmpty) {
                  return 'empty_type'.tr();
                } else {
                  return topic.text.trim();
                }
              }).toList();

              await Topicspreferences.saveTopics(toListString);
              await _loadTopics();
            }
            setState(() {
              isEditMode = !isEditMode;
            });
          },
        ).show();
      },
      child: const Icon(Icons.edit),
    );
  }
}
