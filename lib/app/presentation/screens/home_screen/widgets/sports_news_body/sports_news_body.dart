import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_news/app/presentation/buisness_logic/sports_news_cubit/sports_news_cubit.dart';
import 'package:the_news/app/presentation/screens/home_screen/widgets/general_news_body/cutom_tile_articles.dart';
import 'package:the_news/app/presentation/screens/home_screen/widgets/general_news_body/trending_articles_box.dart';

class SportsNewsBody extends StatelessWidget {
  const SportsNewsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sportsArticle =
        BlocProvider.of<SportsNewsCubit>(context).sportsNewsList;
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 10),
      child: ListView(
        children: [
          TrendingArticlesBox(
            articles: sportsArticle,
            boxHeight: 280,
            imageHeight: 200,
            imageWidth: 300,
            listLength: 3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text("أخبار تهمك", style: Theme.of(context).textTheme.titleLarge),
          ),
          const SizedBox(height: 12),
          CustomTileArticles(
            articles: sportsArticle,
            lengthList: sportsArticle.length,
          ),
        ],
      ),
    );
  }
}
