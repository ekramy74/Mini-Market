import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_market/modules/login/login.dart';
import 'package:mini_market/network/local/cache_helper.dart';
import 'package:mini_market/sharing/components/components.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String title;
  final String body;
  final String image;

  BoardingModel(
      {@required this.title, @required this.image, @required this.body});
}

// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        title: 'OnBoarding 1',
        image: 'assets/images/onboard.jpg',
        body: 'Onboarding1'),
    BoardingModel(
        title: 'OnBoarding 2',
        image: 'assets/images/onboard.jpg',
        body: 'Onboarding2'),
    BoardingModel(
        title: 'OnBoarding 3',
        image: 'assets/images/onboard.jpg',
        body: 'Onboarding3')
  ];

  var boardingControll = PageController();

  bool isLast = false;

  void submit() {
    CacheHelper.saveDate(key: 'OnBoarding', value: true).then((value) {
      if (value) {
        navigateandFinish(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: submit, child: Text('SKIP'))],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward_ios),
        onPressed: () {
          if (isLast == true) {
            submit();
          } else {
            boardingControll.nextPage(
                duration: Duration(milliseconds: 750),
                curve: Curves.fastLinearToSlowEaseIn);
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardingControll,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingitem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SmoothPageIndicator(
              controller: boardingControll,
              count: boarding.length,
              effect: ExpandingDotsEffect(
                  expansionFactor: 4,
                  dotColor: Colors.grey,
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.indigo[300],
                  spacing: 4),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingitem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text('${model.title}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          SizedBox(
            height: 30,
          ),
          Text('${model.body}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      );
}
