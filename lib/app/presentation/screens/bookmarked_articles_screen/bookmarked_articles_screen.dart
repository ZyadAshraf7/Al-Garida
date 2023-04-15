import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_news/app/presentation/buisness_logic/bookmarked_articles_cubit/bookmarked_articles_cubit.dart';
import 'package:the_news/app/presentation/screens/home_screen/widgets/general_news_body/cutom_tile_articles.dart';

import '../../../core/theme/app_theme.dart';

class BookmarkedArtilclesScreen extends StatelessWidget {
  const BookmarkedArtilclesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookmarkedCubit = BlocProvider.of<BookmarkedArticlesCubit>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "الأخبار المحفوظة",
          style: TextStyle(color: AppTheme.grey800),
        ),
        iconTheme: IconThemeData(color: AppTheme.grey800),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: BlocBuilder<BookmarkedArticlesCubit, BookmarkedArticlesState>(
            builder: (context, state) {
              if (state is BookmarkedArticlesLoading) {
                return const Center(
                  heightFactor: 2,
                  child: CircularProgressIndicator(),
                );
              } else if (state is BookmarkedArticlesEmpty) {
                return Center(
                  heightFactor: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/search.png"),
                      SizedBox(height: 24),
                      Text(
                        "لا يوجد أخبار محفوظة لديك",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "تستطيع حفظ الأخبار هنا",
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
                );
              }
              else if(state is BookmarkedArticlesLoadedSuccess) {
                return CustomTileArticles(
                    articles: bookmarkedCubit.bookmarkedArticles,
                    lengthList: bookmarkedCubit.bookmarkedArticles.length);
              }else if(state is BookmarkedArticlesFailed){
                return Center(
                  heightFactor: 2,
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
              }else{
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
