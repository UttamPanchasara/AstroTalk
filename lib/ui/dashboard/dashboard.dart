import 'package:astro_talk/common/colors.dart';
import 'package:astro_talk/common/constants.dart';
import 'package:astro_talk/common/images.dart';
import 'package:astro_talk/common/size_constant.dart';
import 'package:astro_talk/common/text_style_extension.dart';
import 'package:astro_talk/ui/astrologer/astrologer_page.dart';
import 'package:astro_talk/ui/panchang/panchang_page.dart';
import 'package:astro_talk/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with WidgetsBindingObserver {
  final List<Widget> _pagesList = [];
  final BehaviorSubject<int> _pageController = BehaviorSubject<int>();
  DateTime _currentBackPressTime = DateTime.now();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    if (_pagesList.isEmpty) {
      _pagesList.addAll([
        const PanchangPage(),
        const AstrologerPage(),
        Container(),
        Container(),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: scaffoldKey,
      drawer: Drawer(
        child: Container(),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            AppImages.kHamburger,
            fit: BoxFit.cover,
            width: 24.0,
          ),
          onPressed: () {
            AppUtils.instance.showToast(kComingSoon);
            // scaffoldKey.currentState?.openDrawer();
          },
        ),
        centerTitle: true,
        title: Image.asset(
          AppImages.kLogo,
          width: k60Width,
          fit: BoxFit.cover,
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              AppImages.kProfile,
              fit: BoxFit.cover,
              width: 24.0,
            ),
            onPressed: () {
              AppUtils.instance.showToast(kComingSoon);
              // do something
            },
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: StreamBuilder<int>(
            stream: _pageController.stream,
            builder: (context, snapshot) {
              int pageIndex = snapshot.data ?? 0;
              return _pagesList[pageIndex];
            }),
      ),
      //floating action button position to center
      bottomNavigationBar: StreamBuilder<int>(
        stream: _pageController.stream,
        builder: (context, snapshot) {
          int pageIndex = snapshot.data ?? 0;
          return BottomNavigationBar(
            currentIndex: pageIndex,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: Theme.of(context).textTheme.text10Orange(),
            unselectedLabelStyle: Theme.of(context).textTheme.text10Orange(),
            onTap: (index) {
              _pageController.add(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: navIcon(AppImages.kHome),
                activeIcon: navIcon(AppImages.kHome, isActive: true),
                label: kHome,
              ),
              BottomNavigationBarItem(
                icon: navIcon(AppImages.kTalk),
                activeIcon: navIcon(AppImages.kTalk, isActive: true),
                label: kTalkToAstrologer,
              ),
              BottomNavigationBarItem(
                icon: navIcon(AppImages.kAsk),
                activeIcon: navIcon(AppImages.kAsk, isActive: true),
                label: kAskQuestion,
              ),
              BottomNavigationBarItem(
                icon: navIcon(AppImages.kReports),
                activeIcon: navIcon(AppImages.kReports, isActive: true),
                label: kReport,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget navIcon(String icon, {bool isActive = false}) {
    return Image.asset(
      icon,
      width: 24.0,
      fit: BoxFit.cover,
      color: isActive ? AppColors.iconColorOrange : AppColors.iconColorGrey,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.close();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(_currentBackPressTime) > const Duration(seconds: 2)) {
      _currentBackPressTime = now;
      AppUtils.instance.showToast(kPressBackButtonAgain);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
