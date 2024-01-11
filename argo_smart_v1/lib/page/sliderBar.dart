import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> images = [
  'assets/images/iklan.png',
  'assets/images/iklan.png',
  'assets/images/iklan.png',
];

class SliderBar extends StatefulWidget {
  SliderBar({Key? key}) : super(key: key);

  @override
  _SliderBarState createState() => _SliderBarState();
}

class _SliderBarState extends State<SliderBar> {
// Carousel controller
  final CarouselController _controller = CarouselController();

  // ignore: unused_field
  int _current = 0; // Current index of the slider

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              viewportFraction: 1,
              // ignore: non_constant_identifier_names
              onPageChanged: (index, CarouselReason) {
                // ignore: avoid_print
                print(index);
                setState(() {
                  _current = index;
                });
              },
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
            items: images.map((image) {
              return Container(
                height: 80,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.map((image) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(images.indexOf(image)),
                child: Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Color(0xFF40FF51)),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
