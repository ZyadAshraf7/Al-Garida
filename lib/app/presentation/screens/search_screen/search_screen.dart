import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_news/app/core/theme/app_theme.dart';
import 'package:the_news/app/presentation/buisness_logic/search_article_cubit/search_article_cubit.dart';
import 'package:the_news/app/presentation/screens/home_screen/widgets/general_news_body/cutom_tile_articles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final searchCubit = BlocProvider.of<SearchArticleCubit>(context, listen: false);
    searchCubit.searchWordController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: searchCubit.searchWordController,
          style: const TextStyle(color: AppTheme.grey700),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              fillColor: AppTheme.grey200,
              filled: true,
              prefixIcon: SvgPicture.asset(
                "assets/icons/search.svg",
                fit: BoxFit.scaleDown,
              ),
            suffixIcon: IconButton(
                onPressed: () {
                  searchCubit.searchWordController.clear();
                },
                icon: searchCubit.searchWordController.text.isNotEmpty
                    ? const Icon(
                  Icons.clear,
                  size: 20,
                  color: AppTheme.grey700,
                )
                    : const SizedBox()),
              hintText: "بحث",),
          onFieldSubmitted: (value) {
            searchCubit.fetchSearchedArticle(value);
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: BlocBuilder<SearchArticleCubit, SearchArticleState>(
          builder: (context, state) {
            if (state is SearchArticleLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SearchArticleNoResults) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/noSearchResult.png"),
                    SizedBox(height: 24),
                    Text(
                      "لا يوجد نتائج",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "ابحث مجدداً او قم بتغيير كلمة البحث",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              );
            } else if (state is SearchArticleSuccess) {
              return ListView(
                children: [
                  CustomTileArticles(
                    articles: searchCubit.searchedArticles,
                    lengthList: searchCubit.searchedArticles.length,
                  ),
                ],
              );
            } else if (state is SearchArticleFailed) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/error.png"),
                    SizedBox(height: 24),
                    Text(
                      "حدث خطأ أثناء الاتصال",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "برجاء المحاولة في وقت لاحق",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/search.png"),
                    SizedBox(height: 24),
                    Text(
                      "ما الذي تبحث عنه اليوم",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "ابحث عن جميع الاخبار الجديدة و الحصرية",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
