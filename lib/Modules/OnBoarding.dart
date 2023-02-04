import 'package:flutter/material.dart';
import 'package:shop_app1/Modules/Login_Screen.dart';
import 'package:shop_app1/network/Cach_Helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onChange {
  final String im;
  final String t1;
  final String t2;

  onChange({required this.im, required this.t1, required this.t2});
}

class OnBoarding extends StatelessWidget {
  var controllPage = PageController();
  bool cc = false;

  List<onChange> ll = [
    onChange(im: 'images/img_1.png', t1: 'OnBoarding1', t2: 'onddadkls'),
    onChange(im: 'images/img_2.png', t1: 'OnBoarding1', t2: 'onddadkls'),
    onChange(im: 'images/images_4.jpg', t1: 'OnBoarding1', t2: 'onddadkls'),
  ];

  @override
  Widget build(BuildContext context) {
    void Navg() async {
      await CachHelper.SetData(key: "onboarding", value: true).then((value) {
        if (value == true) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false);
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: Navg,
              child: Text(
                'Skip',
                style: Theme.of(context).textTheme.bodyText1,
              ))
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == ll.length - 1) {
                      cc = true;
                    } else {
                      cc = false;
                    }
                  },
                  controller: controllPage,
                  itemBuilder: (context, index) {
                    return onch(ll[index]);
                  },
                  itemCount: ll.length,
                ),
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: controllPage,
                    count: ll.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.black,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 10),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      controllPage.nextPage(
                          duration: Duration(microseconds: 250),
                          curve: Curves.bounceIn);
                      if (cc) {
                        Navg();
                      }
                    },
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget onch(onChange c) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: AssetImage(c.im)),
        SizedBox(
          height: 40,
        ),
        Text(
          c.t1,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          c.t2,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
