import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:the_news/app/core/constants/route_names.dart';
import 'package:the_news/app/core/theme/app_theme.dart';
import 'package:the_news/app/data/models/news_model.dart';
import 'package:the_news/app/presentation/screens/artcile_details_screen/article_details_screen.dart';
import 'package:the_news/app/presentation/screens/home_screen/widgets/general_news_body/top_general_article.dart';
import 'package:the_news/app/presentation/screens/home_screen/widgets/general_news_body/trending_articles_box.dart';
import 'dart:ui' as ui;
import '../../../../buisness_logic/all_news_cubit/all_news_cubit.dart';
import 'cutom_tile_articles.dart';

class GeneralNewsBody extends StatelessWidget {
  const GeneralNewsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final generalArticles =
        BlocProvider.of<AllNewsCubit>(context).generalNewsList;
    final worldArticles = BlocProvider.of<AllNewsCubit>(context).worldNewsList;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ArticleDetailsScreen(
                  article: generalArticles.first,
                ),
              ));
            },
            child: TopGeneralArticleBox(articles: generalArticles.first),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child:
                Text("الشائع", style: Theme.of(context).textTheme.titleLarge),
          ),
          SizedBox(height: 12),
          TrendingArticlesBox(
            articles: generalArticles,
            boxHeight: 200,
            imageWidth: 200,
            imageHeight: 120,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text("حول العالم",
                style: Theme.of(context).textTheme.titleLarge),
          ),
          SizedBox(height: 12),
          CustomTileArticles(
            articles: worldArticles,
            lengthList: worldArticles.length - 5,
          )
        ],
      ),
    );
  }
}
