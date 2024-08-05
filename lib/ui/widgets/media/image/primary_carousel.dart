import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_state.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:web/ui/widgets/media/image/primary_network_image.dart';

class CustomCarouselController extends CarouselControllerImpl {
  CarouselState? _state;

  CarouselState? get state => _state;

  @override
  set state(CarouselState? state) {
    _state = state;
    super.state = state;
  }
}

class PrimaryCarousel extends StatelessWidget {
  final List<String> images;
  PrimaryCarousel({super.key, required this.images});

  final CarouselOptions _carouselOptions = CarouselOptions(
    aspectRatio: 16 / 9,
    viewportFraction: 1,
    initialPage: 0,
    disableCenter: true,
    enableInfiniteScroll: true,
    reverse: false,
    autoPlay: true,
    autoPlayInterval: const Duration(seconds: 3),
    autoPlayAnimationDuration: const Duration(milliseconds: 800),
    autoPlayCurve: Curves.fastOutSlowIn,
    enlargeCenterPage: true,
    enlargeFactor: 0.3,
    onPageChanged: (index, _) {},
    scrollDirection: Axis.horizontal,
  );
  final CustomCarouselController _buttonCarouselController =
      CustomCarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
            itemCount: images.length,
            carouselController: _buttonCarouselController,
            itemBuilder: (context, index, realIndex) => Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: PrimaryNetworkImage(
                    image: images[index],
                    borderRadius: BorderRadius.circular(18),
                    boxFit: BoxFit.cover,
                  ),
                ),
            options: _carouselOptions),
        Positioned(
          bottom: 24,
          left: 0,
          right: 0,
          child: FutureBuilder(
            future: _buttonCarouselController.onReady,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: SmoothPageIndicator(
                      controller:
                          _buttonCarouselController.state!.pageController!,
                      count: images.length,
                      effect: const ExpandingDotsEffect(
                          dotWidth: 8,
                          dotHeight: 8,
                          activeDotColor: Colors.blueAccent,
                          dotColor: Colors.white)),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        )
      ],
    );
  }
}
