import 'package:flutter/material.dart';

import '../../../../../data/models/news_model.dart';

class TopGeneralArticleBox extends StatelessWidget {
  const TopGeneralArticleBox({
    super.key,
    required this.articles,
  });

  final Articles articles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.network(
                  articles.image ?? "",
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Container(
                  // width: 320,
                  height: 250,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.01),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  )),
                ),
                Positioned(
                  bottom: 15,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 300,
                        child: Text(articles.title ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40)),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            articles.source!.name!,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
