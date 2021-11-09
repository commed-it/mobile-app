import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

typedef SetIndexAction = LambdaAction Function(
    int index, CarouselController controller);

typedef DispatchAction = void Function(
    int index, CarouselController controller);

@immutable
class _ImageContainer {
  final ImageContainer imgContainer;
  final DispatchAction dispatchAction;

  const _ImageContainer(this.imgContainer, this.dispatchAction);

  _ImageContainer setIndex(int index) {
    return _ImageContainer(imgContainer.setIndex(index), dispatchAction);
  }
}

@immutable
class ImageContainer {
  final List<String> listOfUrls;
  final int index;
  final SetIndexAction action;

  const ImageContainer(this.listOfUrls, this.index, this.action);

  ImageContainer setIndex(int index) {
    return ImageContainer(listOfUrls, index, action);
  }
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
    return StoreConnector<AppState, _ImageContainer>(
      builder: (ctx, cont) => CarouselSlider(
          carouselController: _controller,
          items: cont.imgContainer.listOfUrls
              .map((e) => Center(child: Image.network(e)))
              .toList(),
          options: CarouselOptions(
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              aspectRatio: 16 / 9,
              onPageChanged: (index, reason) {
                cont.dispatchAction(index, _controller);
              })),
      converter: (store) {
        var imgContainer = getContainer(store);
        return _ImageContainer(imgContainer, (index, controller) {
          print(controller);
          print(index);
          _controller.animateToPage(index);
          store.dispatch(imgContainer.action(index, controller));
        });
      },
    );
  }
}

class CarouselWithIndicatorDemo extends StatefulWidget {
  const CarouselWithIndicatorDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<Widget> get imageSliders => imgList
      .map((item) =>
          Center(child: Image.network(item, fit: BoxFit.cover, width: 1000)))
      .toList();

  List<String> get imgList => [
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
        'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
        'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
        'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
        'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
        'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                // TODO launch event to index
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: CoolCarouselCircle(isActivated: _current == entry.key),
            );
          }).toList(),
        ),
      ],
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
