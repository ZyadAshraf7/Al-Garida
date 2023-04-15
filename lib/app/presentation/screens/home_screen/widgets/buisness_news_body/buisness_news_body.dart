import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_news/app/presentation/screens/home_screen/widgets/general_news_body/cutom_tile_articles.dart';
import 'package:the_news/app/presentation/screens/home_screen/widgets/general_news_body/trending_articles_box.dart';

import '../../../../buisness_logic/buisness_news_cubit/buisness_news_cubit.dart';

class BuisnessNewsBody extends StatelessWidget {
  const BuisnessNewsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buisnessArticles = BlocProvider.of<BuisnessNewsCubit>(context).buisnessNewsList;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView(
        children: [
          CustomTileArticles(articles: buisnessArticles,lengthList: buisnessArticles.length),
        ],
      ),
    );
  }
}
