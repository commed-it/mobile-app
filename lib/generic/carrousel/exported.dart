import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

typedef SetIndexAction = LambdaAction Function(
    int index, CarouselController controller);

@immutable
class ImageContainer {
  final List<String> listOfUrls;

  const ImageContainer(this.listOfUrls);

}

typedef GetContainer = ImageContainer Function(Store<AppState> s);

class GenericCarrousel extends StatelessWidget {
  GenericCarrousel({
    Key? key,
    required this.getContainer,
  }) : super(key: key);

  final GetContainer getContainer;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ImageContainer>(
      builder: (ctx, cont) => Column(
        children: [
          CarouselSlider(
              carouselController: _controller,
              items: cont.listOfUrls
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
      ),
      converter: getContainer,
    );
  }
}

class CoolCarouselCircle extends StatelessWidget {
  const CoolCarouselCircle({Key? key, required this.isActivated})
      : super(key: key);

  final bool isActivated;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12.0,
      height: 12.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black)
              .withOpacity(isActivated ? 0.9 : 0.4)),
    );
  }
}
