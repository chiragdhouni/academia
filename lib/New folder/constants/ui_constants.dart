import 'package:academia/New%20folder/features/explore/view/explore_view.dart';
import 'package:academia/New%20folder/features/tweets/widgets/tweet_list.dart';
import 'package:academia/pages/chat_screen.dart';
import 'package:academia/pages/habit_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:academia/New%20folder/constants/assets_constants.dart';
import 'package:academia/New%20folder/theme/pallete.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: Text(
        "learnLog",
        style: TextStyle(color: Pallete.blueColor, fontFamily: "Baloo Da"),
      ),
      centerTitle: true,
    );
  }

  static const List<Widget> bottomTabBarPages = [
    TweetList(),
    // Text('yoi'),
    ExploreView(),
    ChatScreen(),
    HabitTracker()
  ];
}
