import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:unique/modules/homepage.dart';

class Myslider extends StatefulWidget {
  const Myslider({Key? key}) : super(key: key);

  @override
  _MysliderState createState() => _MysliderState();
}

class _MysliderState extends State<Myslider> {
  final List imgList = [
    //here we add images
    // 'assets/images/img1.jpg',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg',
    'assets/images/icon.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer can be add we want

      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    imgList[index],
                    fit: BoxFit.fill,
                  );
                },
                itemCount: 3,
                // viewportFraction: 0.7,
                // scale: 0.8,
                itemWidth: 400,
                itemHeight: 780.0,
                layout: SwiperLayout.TINDER,
              ),
              Positioned(
                  top: 740,
                  left: 150,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Homepage()));
                      },
                      child: Text('Skip',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          )
                          // decoration: TextDecoration.underline),
                          )))
            ]),
            SizedBox(
              height: 45,
            ),
          ],
        ),
      ),
    );
  }
}
