import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../modules/login/logIn.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../models/onBoarding_model/onboarding_model.dart';

class OnBoarding extends StatelessWidget {
  final pageController = PageController();
  var isLast = false;
  final List<BoardingModel> boarding = [
    BoardingModel(
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
      image: 'assets/images/onboard.jpg',
    ),
    BoardingModel(
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
      image: 'assets/images/onboard.jpg',
    ),
    BoardingModel(
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
      image: 'assets/images/onboard.jpg',
    ),
  ];

  void submit(BuildContext context) {
    CacheHelper.saveData(key: kOnBoarding, value: true).then((value) {
      navigateAndFinish(
        context,
        LogIn(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            label: 'SKIP',
            onPressed: (){
              submit(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (int index) {
                  index++;
                  index == boarding.length ? isLast = true : isLast = false;
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Theme.of(context).primaryColor,
                    dotColor: Colors.grey,
                    dotWidth: 11,
                    dotHeight: 11,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (!isLast) {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    } else {
                      submit(context);
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
