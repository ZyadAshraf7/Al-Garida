import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:the_news/app/core/theme/app_theme.dart';
import 'package:the_news/app/data/models/news_model.dart';
import 'package:the_news/app/presentation/buisness_logic/article_details_cubit/article_details_cubit.dart';
import 'package:the_news/app/presentation/screens/artcile_details_screen/widgets/custom_web_view.dart';
import 'package:the_news/app/presentation/widgets/custom_button.dart';
import 'package:toast/toast.dart';
class ArticleDetailsScreen extends StatelessWidget {
  const ArticleDetailsScreen({Key? key, required this.article})
      : super(key: key);
  final Articles article;


  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    final articleDetailsCubit = BlocProvider.of<ArticleDetailsCubit>(context);
    articleDetailsCubit.checkIfArticleExist(article.publishedAt);
    return Scaffold(
      body: Stack(
        // alignment: Alignment.bottomCenter,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 375,
                child: Image.network(
                  article.image!,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 20,
                right: 10,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.black26),
                      child: SvgPicture.asset(
                        "assets/icons/arrow.svg",
                        color: Colors.white,
                      )),
                ),
              ),
              Positioned(
                top: 20,
                left: 10,
                child: GestureDetector(
                  onTap: () async {
                    if (articleDetailsCubit.articleExist) {
                      print(FirebaseAuth.instance.currentUser?.phoneNumber);
                      FirebaseFirestore.instance.collection("users").doc(
                          FirebaseAuth.instance.currentUser?.phoneNumber).update({
                        'bookmarks': FieldValue.arrayRemove([article.toJson()]),
                      });
                      Toast.show("تم حذف الخبر من الأخبار المحفوظة",duration: Toast.lengthLong,gravity: Toast.bottom);
                    } else {
                      FirebaseFirestore.instance.collection("users").doc(
                          FirebaseAuth.instance.currentUser?.phoneNumber).update({
                        'bookmarks': FieldValue.arrayUnion([article.toJson()]),
                      });
                      Toast.show("تم إضافة الخبر إلى الأخبار المحفوظة",duration: Toast.lengthLong,gravity: Toast.bottom);

                    }
                    articleDetailsCubit.toggleArticleExistance();
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.black26),
                    child: BlocBuilder<ArticleDetailsCubit, ArticleDetailsState>(
                      builder: (context, state) {
                        if(state is ArticleExist) {
                          return SvgPicture.asset(
                            "assets/icons/BookmarkFilled.svg",
                            color: Colors.white,
                          );
                        }else{
                          return SvgPicture.asset(
                            "assets/icons/bookmark.svg",
                            color: Colors.white,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          DraggableScrollableSheet(
              initialChildSize: 0.55,
              maxChildSize: 0.68,
              minChildSize: 0.55,
              builder: (context, controller) {
                return Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 35,
                            height: 5,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(40)),
                          ),
                          SizedBox(height: 8),
                          Text(
                            article.title!,
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 20),
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                article.source!.name!,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                article.publishedAt!.substring(0,10),
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          SizedBox(height: 24),
                          Text(
                            article.content!,
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: AppTheme.grey700),
                          ),
                          SizedBox(height: 24),
                          CustomButton(
                              title: "شاهد الخبر كاملاُ",
                              hasColor: true,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) =>
                                        CustomWebView(url: article.url!)));
                              },
                              titleColor: Colors.white)
                        ],
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
