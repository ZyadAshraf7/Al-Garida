import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_news/app/presentation/screens/home_screen/widgets/general_news_body/cutom_tile_articles.dart';
import 'package:the_news/app/presentation/screens/home_screen/widgets/general_news_body/top_general_article.dart';

import '../../../../buisness_logic/health_news_cubit/health_news_cubit.dart';

class HealthNewsBody extends StatelessWidget {
  const HealthNewsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final healthArticles = BlocProvider.of<HealthNewsCubit>(context).healthNewsList;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView(
        children: [
          TopGeneralArticleBox(articles: healthArticles.first),
          SizedBox(height: 10),
          CustomTileArticles(articles: healthArticles,lengthList: healthArticles.length,)
        ],
      ),
    );
  }
}
