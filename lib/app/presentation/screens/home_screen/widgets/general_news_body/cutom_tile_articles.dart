import 'package:flutter/material.dart';
import 'package:the_news/app/presentation/screens/artcile_details_screen/article_details_screen.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../data/models/news_model.dart';

class CustomTileArticles extends StatelessWidget {
  const CustomTileArticles({
    super.key,
    required this.articles,
    this.lengthList,
  });

  final List<Articles> articles;
  final int? lengthList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 370,
      child: ListView.separated(
        padding: const EdgeInsets.only(right: 24.0),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: lengthList ?? 3,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ArticleDetailsScreen(article: articles[i]))),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 80,
                    height: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        articles[i].image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  SizedBox(
                    width: 270,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          articles[i].title!,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Text(
                          articles[i].source!.name!,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: AppTheme.grey600),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 28);
        },
      ),
    );
  }
}
