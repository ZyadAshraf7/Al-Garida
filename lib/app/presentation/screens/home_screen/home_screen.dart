import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_news/app/core/theme/app_theme.dart';
import 'package:the_news/app/data/repositories/base_news_repository.dart';
import 'package:the_news/app/presentation/buisness_logic/all_news_cubit/all_news_cubit.dart';
import 'package:the_news/app/presentation/buisness_logic/buisness_news_cubit/buisness_news_cubit.dart';
import 'package:the_news/app/presentation/buisness_logic/health_news_cubit/health_news_cubit.dart';
import 'package:the_news/app/presentation/buisness_logic/sports_news_cubit/sports_news_cubit.dart';
import 'package:the_news/app/presentation/buisness_logic/technology_news_cubit/technology_news_cubit.dart';
import 'package:the_news/app/presentation/screens/home_screen/widgets/buisness_news_body/buisness_news_body.dart';
import 'package:the_news/app/presentation/screens/home_screen/widgets/general_news_body/general_news_body.dart';
import 'package:the_news/app/presentation/screens/home_screen/widgets/health_news_body/health_news_body.dart';
import 'package:the_news/app/presentation/screens/home_screen/widgets/sports_news_body/sports_news_body.dart';
import 'package:the_news/app/presentation/screens/home_screen/widgets/technology_news_body/technology_news_body.dart';
import 'package:the_news/app/presentation/widgets/loading_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  late TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,

          title: Row(
            children: [
              SizedBox(width: 35,height: 35,child: SvgPicture.asset("assets/icons/logo.svg")),
              SizedBox(width: 10),
              Text("الجريدة",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black,fontWeight: FontWeight.bold),),
            ],
          ),
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            controller: _controller,
            indicatorPadding: EdgeInsets.all(4),
            isScrollable: true,
            labelColor: AppTheme.grey600,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.black,
            tabs: const [
              Tab(text: "كل الاخبار"),
              Tab(text: "الرياضة"),
              Tab(text: "التكنولوجيا"),
              Tab(text: "التجارة"),
              Tab(text: "الصحة"),
            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            BlocBuilder<AllNewsCubit, AllNewsState>(
              builder: (context, state) {
                if(state is AllNewsLoading){
                  return const LoadingBody();
                }else{
                  return GeneralNewsBody();
                }
              },
            ),
            BlocBuilder<SportsNewsCubit, SportsNewsState>(
              builder: (context, state) {
                if(state is SportsNewsLoading){
                  return const Center(child: CircularProgressIndicator(),);
                }else{
                  return const SportsNewsBody();
                }
              },
            ),
            BlocBuilder<TechnologyNewsCubit, TechnologyNewsState>(
              builder: (context, state) {
                if(state is TechnologyNewsLoading){
                  return const Center(child: CircularProgressIndicator(),);
                }else{
                  return const TechnologyNewsBody();
                }
              },
            ),
            BlocBuilder<BuisnessNewsCubit, BuisnessNewsState>(
              builder: (context, state) {
                if(state is BuisnessNewsLoading){
                  return const Center(child: CircularProgressIndicator(),);
                }else{
                  return const BuisnessNewsBody();
                }
              },
            ),
            BlocBuilder<HealthNewsCubit, HealthNewsState>(
              builder: (context, state) {
                if(state is HealthNewsLoading){
                  return const Center(child: CircularProgressIndicator(),);
                }else{
                  return const HealthNewsBody();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
