import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_news/app/presentation/buisness_logic/technology_news_cubit/technology_news_cubit.dart';
import 'package:the_news/app/presentation/screens/home_screen/widgets/general_news_body/cutom_tile_articles.dart';
import 'package:the_news/app/presentation/screens/home_screen/widgets/general_news_body/trending_articles_box.dart';

class TechnologyNewsBody extends StatelessWidget {
  const TechnologyNewsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final technologyArticles =
        BlocProvider.of<TechnologyNewsCubit>(context).technologyNewsList;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView(
        children: [
          TrendingArticlesBox(
            articles: technologyArticles,
            boxHeight: 470,
            imageHeight: 400,
            imageWidth: 300,
            listLength: 4,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text("أخر الأخبار", style: Theme.of(context).textTheme.titleLarge),
          ),
          const SizedBox(height: 12),
          CustomTileArticles(articles: technologyArticles,lengthList: technologyArticles.length,)
        ],
      ),
    );
  }
}
