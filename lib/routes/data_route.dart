import 'package:flutter/material.dart';
import 'package:idou/blocs/bloc_provider.dart';
import 'package:idou/blocs/data/hot_sentence_bloc.dart';
import 'package:idou/blocs/data/hot_video_bloc.dart';
import 'package:idou/blocs/data/star_hot_bloc.dart';
import 'package:idou/pages/data/hot_sentence_page.dart';
import 'package:idou/pages/data/hot_video_page.dart';
import 'package:idou/pages/data/star_hot_page.dart';
import 'package:idou/pages/vip/vip_page.dart';

class DataRoute {
  static const String routeHotVideo = 'hot_video';
  static const String routeStarHot = 'star_hot';
  static const String routeHotSentence = 'hot_sentence';
  static const String routeVipPage = 'vip_page';

  static final routes = <String, WidgetBuilder>{
    routeHotVideo: (context) =>
        BlocProvider(child: HotVideoPage(), bloc: HotVideoBloc()),
    routeStarHot: (context) =>
        BlocProvider(child: StarHotPage(), bloc: StarHotBloc()),
    routeHotSentence: (context) =>
        BlocProvider(child: HotSentencePage(), bloc: HotSentenceBloc()),
    routeVipPage: (context) => VipPage(),
  };
}
