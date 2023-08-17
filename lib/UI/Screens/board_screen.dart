import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sports_101/UI/Screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sports_101/UI/Screens/splash_screen.dart';
import '../../Shared/shared_container_onboard.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isLastPage = false;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    const autoPlayDuration = Duration(seconds: 3);
    _timer = Timer.periodic(
      autoPlayDuration,
      (timer) {
        if (_currentPage < 2) {
          _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        }
      },
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _skipOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('showHome', false);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Align(
              alignment: const Alignment(0, .3),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.transparent,
                ),
                height: MediaQuery.of(context).size.height * .70,
                width: MediaQuery.of(context).size.width * 0.80,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => isLastPage = index == 2);
                  },
                  children: const [
                    Boarding(
                      imagePass: "assets/Images/Basket_ch.png",
                      uniSize: .6,
                      backgroundColor: Colors.transparent,
                      title:
                          'Welcome to Sports 101\n\n Join us for the ultimate sports experience.',
                    ),
                    Boarding(
                      imagePass: "assets/Images/football_ch.png",
                      uniSize: 0.78,
                      backgroundColor: Colors.transparent,
                      title: 'Discover the excitement of the world of sports.',
                    ),
                    Boarding(
                      imagePass: "assets/Images/baseball_2.png",
                      uniSize: .6,
                      backgroundColor: Colors.transparent,
                      title:
                          'You\'re all set to start your sports journey with us!',
                    ),
                  ],
                ),
              ),
            ),
          ),
          //
        ],
      ),
      bottomSheet: Container(
        color: Colors.black,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: SizedBox(
                width: 95.w,
                height: 8.h,
              ),
              // child: Text(
              //   '',
              //   style:
              //       TextStyle(color: Colors.white60, fontSize: 20.sp),
              // ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              onDotClicked: (index) => _goToPage(index),
              effect: WormEffect(
                activeDotColor: Colors.white,
                dotColor: Colors.white30,
                dotHeight: 10.h,
                dotWidth: 10.w,
                spacing: 10.w,
              ),
            ),
            GestureDetector(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);

                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xFF1D1C21),
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 8.w),
                child: Text(
                  'Skip',
                  style: TextStyle(color: Colors.white60, fontSize: 20.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
