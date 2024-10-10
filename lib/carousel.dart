import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'game_models.dart'; // models of cards, game and players, cards data

import 'main.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> imageAssets; // Список адресов изображений
  final int sectionNumber; // Номер раздела для формирования айди карты
  final Function(CardModel) pick; // Функция для выбора карты
  final Function(CardModel) info; // Функция для вывода описания карты

  const ImageCarousel({
    super.key,
    required this.imageAssets,
    required this.sectionNumber,
    required this.pick,
    required this.info,
  });

  @override
  ImageCarouselState createState() => ImageCarouselState();
}

class ImageCarouselState extends State<ImageCarousel> {
  int _currentImageIndex = 0; // Индекс текущего изображения
  final CarouselSliderController _carouselController =
      CarouselSliderController(); // Создаем контроллер
  List<String> abaddonedCards = [
    '../assets/images/abaddonedCards/abaddonedCard1.png',
    '../assets/images/abaddonedCards/abaddonedCard2.png',
    '../assets/images/abaddonedCards/abaddonedCard3.png',
    '../assets/images/abaddonedCards/abaddonedCard4.png'
  ];

  CardModel _currentCard() {
    if (widget.sectionNumber < 4) {
      return characterCards[widget.sectionNumber * 7 + _currentImageIndex];
    } else {
      return assistCards[_currentImageIndex];
    }
  }

  bool _isPicked() {
    if (widget.sectionNumber < 4) {
      return selectedCharacterCards.contains(
          characterCards[widget.sectionNumber * 7 + _currentImageIndex]);
    } else {
      return selectedAssistCards.contains(assistCards[_currentImageIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: CarouselSlider(
            carouselController: _carouselController, // Передаем контроллер
            items: widget.imageAssets.map((imageAsset) {
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  width: 550 * 0.643, // Ширина экрана
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        imageAsset,
                      ),
                    ),
                  ),
                  child: GestureDetector(
                      onTap: () {
                        CardGameApp.isCardMovingToSlot = true;
                        widget.pick(_currentCard());
                      },
                      child: _isPicked()
                          ? Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    abaddonedCards[_currentImageIndex % 4],
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(0, 0, 0, 0)),
                            )),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              scrollPhysics: const ScrollPhysics(
                  parent:
                      NeverScrollableScrollPhysics()), // Не листается by drag of the carousel
              height: 550.0, // Высота карусели
              viewportFraction: 1.0, // Занимает всю ширину экрана
              enlargeCenterPage:
                  false, // Без увеличения центрального изображения
              onPageChanged: (index, reason) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
            ),
          ),
        ),
        //info
        Positioned(
          right: 62.0,
          top: 125.0,
          child: IconButton(
            onPressed: () {
              widget.info(_currentCard());
            },
            icon: const Icon(Icons.info_outline, size: 50.0),
          ),
        ),
        // Стрелка влево
        Positioned(
          left: 25.0,
          top: 400.0,
          child: IconButton(
            onPressed: () {
              _carouselController.previousPage(
                // Используем контроллер
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            icon: const Icon(Icons.arrow_back_ios, size: 40.0),
          ),
        ),
        // Стрелка вправо
        Positioned(
          right: 25.0,
          top: 400.0,
          child: IconButton(
            onPressed: () {
              _carouselController.nextPage(
                // Используем контроллер
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            icon: const Icon(Icons.arrow_forward_ios, size: 40.0),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              '${_currentImageIndex + 1}/${widget.imageAssets.length}', // Номер изображения
              style: const TextStyle(
                fontSize: 27,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
