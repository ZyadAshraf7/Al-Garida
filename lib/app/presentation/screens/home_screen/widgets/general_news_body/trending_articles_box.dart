import 'package:flutter/material.dart';

import '../../../../../data/models/news_model.dart';
import '../../../artcile_details_screen/article_details_screen.dart';

class TrendingArticlesBox extends StatelessWidget {
  const TrendingArticlesBox({
    super.key,
    required this.articles,
    required this.boxHeight,
    required this.imageHeight,
    required this.imageWidth,
    this.listLength,
  });

  final List<Articles> articles;
  final double boxHeight;
  final double imageHeight;
  final double imageWidth;
  final int? listLength;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        height: boxHeight,
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 24),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) =>
                      ArticleDetailsScreen(article: articles[i + 1]))),
              child: Column(
                children: [
                  Container(
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: imageWidth,
                            height: imageHeight,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Image.network(
                                articles[i + 1].image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: imageWidth - 10,
                            child: Text(
                              articles[i + 1].title!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w700),
                              maxLines: 2,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
          itemCount: listLength ?? articles.length - 1,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(width: 16);
          },
        ),
      ),
    );
  }
}
