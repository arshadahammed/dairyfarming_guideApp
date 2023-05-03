import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:dairyfarm_guide/ads_helper/app_open_admanager.dart';
import 'package:dairyfarm_guide/screens/account.dart';
import 'package:dairyfarm_guide/screens/explore.dart';
import 'package:dairyfarm_guide/screens/favourite_list.dart';
import 'package:dairyfarm_guide/screens/home.dart';
import 'package:dairyfarm_guide/widgets/snackbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  DateTime preBackpress = DateTime.now();
  int _selectedIndex = 0;
  late PageController _pageController;

  AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    appOpenAdManager.loadAd();
    WidgetsBinding.instance.addObserver(this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      isPaused = true;
    }
    if (state == AppLifecycleState.resumed && isPaused) {
      // print("Resumed==========================");
      appOpenAdManager.showAdIfAvailable();
      isPaused = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(preBackpress);
        //  print('$timegap');
        final canExit = timegap >= const Duration(seconds: 2);

        preBackpress = DateTime.now();
        if (canExit) {
          //show snackbar
          // const snack = SnackBar(
          //   content: Text('Press back button again to Exit'),
          //   duration: Duration(seconds: 2),
          // );
          // ScaffoldMessenger.of(context).showSnackBar(snack);
          EssentialWidgets.showSnackBar(
              context, "Press back button again to Exit");
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        //appBar: AppBar(),
        // drawer: const DrawerWidget(),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: const [
              //subHomePAge
              HomePage(),
              ExplorePage(),
              FavouriteList(),
              AccountPage(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _selectedIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _pageController.jumpToPage(index);
          }),
          items: [
            BottomNavyBarItem(
                icon: const Icon(Icons.home_rounded),
                title: const Text('Home'),
                activeColor: Colors.green,
                inactiveColor: const Color.fromARGB(255, 179, 75, 75)),
            BottomNavyBarItem(
              icon: const Icon(Icons.bar_chart_rounded),
              title: const Text('All Courses'),
              inactiveColor: Colors.grey[500],
              activeColor: Colors.green,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.favorite_outline_rounded),
              title: const Text('Favourite'),
              inactiveColor: Colors.grey[500],
              activeColor: Colors.green,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.person_outline_rounded),
              title: const Text('Account'),
              inactiveColor: Colors.grey[500],
              activeColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
