import 'package:ai_expense_tracker/core/utils/size_config.dart';
import 'package:ai_expense_tracker/features/ai_caht/presentation/pages/ai_chat_view/ai_chat_view.dart';
import 'package:ai_expense_tracker/features/analytics/presentation/pages/reports/reports_view.dart';
import 'package:ai_expense_tracker/features/home/presentation/pages/home_view/home_view.dart';
import 'package:ai_expense_tracker/features/transactions/presentation/pages/transactions/transactions_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class NavigationShell extends StatelessWidget {
  NavigationShell({super.key});

  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );

  List<Widget> _buildScreens() {
    return [
      HomeView(key: ValueKey('home_view')),
      TransactionsView(key: ValueKey('transaction_view')),
      ReportsView(key: ValueKey('reports_view')),
      AiChatView(key: ValueKey('aiChat_view')),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(ColorScheme colors) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        activeColorPrimary: colors.primary,
        inactiveColorPrimary: colors.onSurfaceVariant,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.payments_rounded),
        title: ("Transaction"),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        activeColorPrimary: colors.primary,
        inactiveColorPrimary: colors.onSurfaceVariant,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.description),
        title: ("Reports"),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        activeColorPrimary: colors.primary,
        inactiveColorPrimary: colors.onSurfaceVariant,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesomeIcons.robot, size: 22),
        title: ("AI Chat"),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        activeColorPrimary: colors.primary,
        inactiveColorPrimary: colors.onSurfaceVariant,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(colors),
      navBarHeight: SizeConfig.defaultSize! * 7,
      confineToSafeArea: true,
      backgroundColor: colors.surface,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(20.0),
        colorBehindNavBar: colors.background,
      ),
      //popAllScreensOnTapOfSelectedTab: true,
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      navBarStyle: NavBarStyle.style14,
    );
  }
}
