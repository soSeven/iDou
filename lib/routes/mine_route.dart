
import 'package:flutter/material.dart';
import 'package:idou/pages/mine/cashBag/cash_bag_page.dart';
import 'package:idou/pages/mine/cashBag/cash_cpm_page.dart';
import 'package:idou/pages/mine/feedback/feedback_page.dart';
import 'package:idou/pages/mine/income/income_page.dart';
import 'package:idou/pages/mine/login/phone_login_page.dart';
import 'package:idou/pages/mine/mine_page.dart';
import 'package:idou/pages/mine/setting_page.dart';
import 'package:idou/pages/mine/message/message_page.dart';
import 'package:idou/pages/mine/invite/invite_page.dart';
import 'package:idou/pages/mine/team/team_page.dart';

class MineRoute {

  static final routes = <String, WidgetBuilder> {
    'mine': (context) => MinePage(),
    'mine_setting'     : (context) => SettingPage(),
    'mine_message'     : (context) => MessagePage(),
    'mine_invite'      : (context) => InvitePage(),
    'mine_team'        : (context) => TeamPage(),
    'mine_income'      : (context) => IncomePage(),
    'mine_cash_bag'    : (context) => CashBagPage(),
    'mine_cash_cpm'    : (context) => CashCmpPage(),
    'mine_feedback'    : (context) => FeedbackPage(),
    'mine_phone_login' : (context) => PhoneLoginPage()
  };

}