import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

@immutable
class ImageContainer {
  final List<String> listOfUrls;

  const ImageContainer(this.listOfUrls);

}

class GenericCarrousel extends StatelessWidget {

  GenericCarrousel({
    Key? key,
    required this.imageContainer,
  }) : super(key: key);

  final ImageContainer imageContainer;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
          CarouselSlider(
              carouselController: _controller,
              items: imageContainer.listOfUrls
                  .map((e) => Center(child: Image.network(e)))
                  .toList(),
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  aspectRatio: 1.85,
                disableCenter: true,
                  )
          ),
        ],
    );
  }
}

