import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> imageAssets; // Список адресов изображений
  final int sectionNumber; // Номер раздела для формирования айди карты

  const ImageCarousel({
    super.key,
    required this.imageAssets,
    required this.sectionNumber,
  });

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentImageIndex = 0; // Индекс текущего изображения
  final CarouselSliderController _carouselController = CarouselSliderController(); // Создаем контроллер

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
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: 550*0.643, // Ширина экрана
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
                        setState(() {
                          // TODO: выбор карточки по нажатию
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(),
                      )
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 550.0, // Высота карусели
              viewportFraction: 1.0, // Занимает всю ширину экрана
              enlargeCenterPage: false, // Без увеличения центрального изображения
              onPageChanged: (index, reason) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
            ),
          ),
        ),
        // Стрелка влево
        Positioned(
          left: 25.0,
          top: 400.0,
          child: IconButton(
            onPressed: () {
              _carouselController.previousPage( // Используем контроллер
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
              _carouselController.nextPage( // Используем контроллер
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

// Модель карты
class CardModel {
  String name;
  int health;
  int shield;
  String cardClass;
  String skill;
  String ultimate;
  String passiveSkill;
  bool isSupport;

  CardModel({
    required this.name,
    this.health = 10,
    this.shield = 0,
    required this.cardClass,
    this.skill = "",
    this.ultimate = "",
    this.passiveSkill = "",
    this.isSupport = false,
  });
}

// Модель игрока
class PlayerModel {
  String name;
  List<CardModel> cards;
  int energy;
  CardModel? activeCard;

  PlayerModel({
    required this.name,
    required this.cards,
    this.activeCard,
    this.energy = 8,
  });

  void resetEnergy() {
    energy = 8;
  }
}

// Модель игры
class GameModel {
  PlayerModel player1;
  PlayerModel player2;
  bool player1Turn = true;
  int round = 1;

  GameModel({
    required this.player1,
    required this.player2,
  });

  void nextTurn() {
    player1Turn = !player1Turn;
  }

  void nextRound() {
    round++;
    player1.resetEnergy();
    player2.resetEnergy();
  }

  void endGame() {
    // Завершение игры
  }
}

// Карты персонажей
List<CardModel> characterCards = [
  CardModel(name: "Роман Аксенов", cardClass: "Саппорт", skill: "Поиск слушателей", ultimate: "Скороговорка", passiveSkill: "Ловкая махинация"),
  CardModel(name: "Владислав Лайхтман", cardClass: "Саппорт", skill: "ПП-шечка", ultimate: "Трудности саппорта", passiveSkill: "Модный приговор"),
  CardModel(name: "Ксения Лелюх", cardClass: "Саппорт", skill: "Вор очаровашка", ultimate: "Пуленепробиваемость", passiveSkill: "Каждый сам за себя"),
  CardModel(name: "Алеся Лопаткова", cardClass: "Саппорт", skill: "Дубайский подарок", ultimate: "Мышеловка", passiveSkill: "Сила дружбы"),
  CardModel(name: "Мария Николаева", cardClass: "Саппорт", skill: "Дизайнерское решение", ultimate: "Изысканный вкус", passiveSkill: "Помощь ближнему"),
  CardModel(name: "Диана Плыгун", cardClass: "Саппорт", skill: "Ты в тренде", ultimate: "Роковая улыбка", passiveSkill: "Вечно в тонусе"),
  CardModel(name: "Никита Трошин", cardClass: "Саппорт", skill: "Вести за собой", ultimate: "Perfecto", passiveSkill: "Помощь на века"),
  CardModel(name: "Анастасия Чижова", cardClass: "Дамаггер", skill: "Надменный жест", ultimate: "Полная антисанитария", passiveSkill: "Травля"),
  CardModel(name: "Полина Евстафьева", cardClass: "Дамаггер", skill: "Тебя к телефону", ultimate: "Время - деньги", passiveSkill: "Лёгкое усиление"),
  CardModel(name: "Софья Фефелова", cardClass: "Дамаггер", skill: "Больше пресса", ultimate: "Ну и кадр!", passiveSkill: "По образу и подобию"),
  CardModel(name: "Денис Кольцов", cardClass: "Дамаггер", skill: "Око за око", ultimate: "Токсичность", passiveSkill: "Легкая добыча"),
  CardModel(name: "Михаил Лёвкин", cardClass: "Дамаггер", skill: "Бальный бумеранг", ultimate: "Танец смерти", passiveSkill: "Искра разрушения"),
  CardModel(name: "Анастасия Сирина", cardClass: "Дамаггер", skill: "Лидер долгов", ultimate: "Неизвестность", passiveSkill: "Расширение территории"),
  CardModel(name: "Эдвард Сон", cardClass: "Дамаггер", skill: "Музыкальная лотерея", ultimate: "Идеальное звучание", passiveSkill: "Нотный разлад"),
  CardModel(name: "Владислав Бадмаев", cardClass: "Хиллер", skill: "Сладкоешка", ultimate: "Беречь до последнего", passiveSkill: "Поняшимся?"),
  CardModel(name: "Артём Ледовских", cardClass: "Хиллер", skill: "Мальчик, который выжил", ultimate: "Иллюзия века", passiveSkill: "Помощь друга"),
  CardModel(name: "Полина Пермякова", cardClass: "Хиллер", skill: "Кошачья лапка", ultimate: "Мурчащая мелодия", passiveSkill: "Девять жизней"),
  CardModel(name: "Даниил Рябов", cardClass: "Хиллер", skill: "Приказ", ultimate: "Капитан корабля", passiveSkill: "Сила воли"),
  CardModel(name: "Руфина Шарипова", cardClass: "Хиллер", skill: "Сплетня", ultimate: "Сладкая подмога", passiveSkill: "Крепкий орешек"),
  CardModel(name: "Сергей Шевняков", cardClass: "Хиллер", skill: "Кнут и пряник", ultimate: "Подмена", passiveSkill: "Исцеляющая легкость"),
  CardModel(name: "Александр Звездаков", cardClass: "Хиллер", skill: "Мемология", ultimate: "Душевное равновесие", passiveSkill: "Сила господа"),
  CardModel(name: "Данил Агафонов", cardClass: "Щитовик", skill: "Удар по больному", ultimate: "Бьёшь, как девчонка", passiveSkill: "Кешбэк"),
  CardModel(name: "Даниил Архипенков", cardClass: "Щитовик", skill: "Легендарные строки", ultimate: "Вечеринка с бассейном", passiveSkill: "Помощь слабым"),
  CardModel(name: "Михаил Дрофичев", cardClass: "Щитовик", skill: "Если драка неизбежна...", ultimate: "Любимчик", passiveSkill: "Копилка"),
  CardModel(name: "Денис Федоров", cardClass: "Щитовик", skill: "Один вам, один мне", ultimate: "Всё на кон", passiveSkill: "Чувство меры"),
  CardModel(name: "Владислав Горбунов", cardClass: "Щитовик", skill: "Опасные игры", ultimate: "Лютая защита", passiveSkill: "Зеркало"),
  CardModel(name: "Дарья Кучер", cardClass: "Щитовик", skill: "Позитивный настрой", ultimate: "+вайб", passiveSkill: "Заряд энергии"),
  CardModel(name: "Филипп Воробьев", cardClass: "Щитовик", skill: "Беззвучный режим", ultimate: "Терпит-терпит, а потом терпит-терпит", passiveSkill: "Бывалый"),
];

// Карты подмоги
List<CardModel> supportCards = [
  CardModel(name: "Мансарда", cardClass: "Постоянная", isSupport: true),
  CardModel(name: "МиМ", cardClass: "Периодическая", isSupport: true),
  CardModel(name: "СВП", cardClass: "Периодическая", isSupport: true),
  CardModel(name: "Твоё шоу", cardClass: "Постоянная", isSupport: true),
];

class CustomBoxShadows {
  static List<BoxShadow> get shadowOnDark => const [
    BoxShadow(
      color: Color.fromARGB(99, 0, 0, 0),
      blurRadius: 28,
      offset: Offset(4,12),
    ),
    BoxShadow(
      color: Color.fromARGB(87, 0, 0, 0),
      blurRadius: 50,
      offset: Offset(17,47),
    ),
  ];
  static List<BoxShadow> get shadowOnBright => const [
    BoxShadow(
      color: Color.fromARGB(16, 10, 10, 10),
      blurRadius: 28,
      offset: Offset(4,12),
    ),
    BoxShadow(
      color: Color.fromARGB(23, 10, 10, 10),
      blurRadius: 20,
      offset: Offset(17,47),
    ),
  ];
}

class BorderedSocket extends StatelessWidget {
  final Widget? child;
  final double radius;
  final double height;
  final double width;
  final bool isBackBright;

  const BorderedSocket({
    super.key,
    this.radius = 0,
    this.isBackBright = false,
    this.height = 0,
    this.width = 0,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        if (width > 0 && height > 0) Container(
          alignment: AlignmentDirectional.center,
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 16, 16, 16),
            borderRadius: BorderRadius.circular(radius+5),
            boxShadow: isBackBright
            ? CustomBoxShadows.shadowOnBright
            : CustomBoxShadows.shadowOnDark
          ),
          child: child,
        )
        else Container(
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 16, 16, 16),
            borderRadius: BorderRadius.circular(radius+5),
            border: Border.all(
              color: const Color.fromARGB(255, 16, 16, 16),
              width: 9,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
            boxShadow: isBackBright
            ? CustomBoxShadows.shadowOnBright
            : CustomBoxShadows.shadowOnDark
          ),
          child: child,
        ),

        if (width > 0 && height > 0) DottedBorder(
          color: const Color.fromARGB(255, 139, 139, 139),
          padding: const EdgeInsets.all(11),
          strokeWidth: 8,
          radius: Radius.circular(radius),
          borderType: BorderType.RRect,
          dashPattern: const [
            24.2,
            22
          ],
          child: SizedBox(
            height: height-30,
            width: width-30,
          ),
        )
        else DottedBorder(
          color: const Color.fromARGB(255, 139, 139, 139),
          padding: const EdgeInsets.all(11),
          strokeWidth: 8,
          radius: Radius.circular(radius),
          borderType: BorderType.RRect,
          dashPattern: const [
            24.2,
            22
          ],
          child: Container(),
        ),
      ]
    );
  }
}

class ExpandablePanel extends StatefulWidget {
  final Widget background;
  final Widget title;
  final Widget? content;
  final double minH;//height
  final double maxH;
  final double minW;//width
  final double maxW;
  final double minY;//offset y
  final double maxY;
  final double minX;//offset x
  final double maxX;
  final double minTO;//title offset
  final double maxTO;
  final bool selfActivating;
  final Function? unload;
  
  const ExpandablePanel({
    super.key,
    required this.background,
    required this.title,
    this.content,
    this.minH = 115,
    this.maxH = 1200,
    this.minW = 290,
    this.maxW = 750,
    this.minY = 571,
    this.maxY = 1590,
    this.minX = 163,
    this.maxX = 610,
    this.minTO = 15,
    this.maxTO = 67.5,
    this.selfActivating = false,
    this.unload,
  });

  @override
  // ignore: no_logic_in_create_state
  State<ExpandablePanel> createState() => selfActivating ? _AutoExpandablePanelState() : _ExpandablePanelState();
}

class _ExpandablePanelState extends State<ExpandablePanel> {//for class choose panel
  bool _isExpanded = false;
  double _height = 0;
  double _width = 0;
  double offsetY = -1;
  double offsetX = -1;
  double titleOffset = -1;

  void setExpand(bool value) {
    _isExpanded = value;
    _height = _isExpanded ? widget.maxH : widget.minH;
    _width = _isExpanded ? widget.maxW : widget.minW;
    offsetY = _isExpanded ? widget.minY : widget.maxY;
    offsetX = _isExpanded ? widget.minX : widget.maxX;
    titleOffset = _isExpanded ? widget.maxTO : widget.minTO;
  }

  @override
  Widget build(BuildContext context) {
    if (_height == 0) _height = widget.minH;
    if (_width == 0) _width = widget.minW;
    if (offsetY == -1) offsetY = widget.maxY;
    if (offsetX == -1) offsetX = widget.maxX;
    if (titleOffset == -1) titleOffset = widget.minTO;

    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              setExpand(false);
              widget.unload!();
            });
          },
          child: _isExpanded ? Container(
            decoration: const BoxDecoration(),
          ) : null,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              setExpand(true);
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _height,
            width: _width,
            margin: EdgeInsets.only(top: offsetY, left: offsetX),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                widget.background,
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: titleOffset),
                  child: widget.title,
                ),
                if (_isExpanded)
                  widget.content ?? const SizedBox()
              ]
            ),
          ),
        )
      ],
    );
  }
}

class _AutoExpandablePanelState extends State<ExpandablePanel> with SingleTickerProviderStateMixin { // for card choose panel
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _isExpanded = true;
  bool _isAnimEnded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1.0).animate(_controller);
    _controller.forward(); // Запускаем анимацию увеличения при создании
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAnimEnded) {
      widget.unload!();
      return const SizedBox.shrink();
    }

    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
              _controller.reverse().then((_) {
                setState(() {
                  _isAnimEnded = true;
                });
              });
            });
          },
          child: Container(decoration: const BoxDecoration()),
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              height: widget.minH + _animation.value*(widget.maxH - widget.minH),
              width: widget.minW + _animation.value*(widget.maxW - widget.minW),
              margin: EdgeInsets.only(
                top: widget.maxY + _animation.value*(widget.minY - widget.maxY),
                left: widget.maxX + _animation.value*(widget.minX - widget.maxX)
              ),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  widget.background,
                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(top: widget.minTO + _animation.value*(widget.maxTO - widget.minTO)),
                    child: widget.title,
                  ),
                  if (_isExpanded)
                    widget.content ?? const SizedBox()
                ]
              ),
            );
          },
        ),
      ]
    );
  }
}

// Виджет игры
class CardGameApp extends StatefulWidget {
  @override
  _CardGameAppState createState() => _CardGameAppState();
}

class _CardGameAppState extends State<CardGameApp> {
  GameModel? game;
  bool inLobby = true;
  bool inChooseMode = false;
  int cardsSectionNum = 0;

  // Выбранные карты
  List<CardModel> selectedCharacterCards = [];
  List<CardModel> selectedSupportCards = [];

  void _gotoRools() {
    // TODO: запуск меню правил
  }

  // Запуск игры с выбранными картами
  void _startGame(List<CardModel> characterCards, List<CardModel> supportCards) {
    game = GameModel(
      player1: PlayerModel(name: "Игрок 1", cards: characterCards + supportCards),
      player2: PlayerModel(name: "Игрок 2", cards: characterCards + supportCards),// TODO: выдача игрокам выбранных ими карт
    );
    setState(() {
      inLobby = false;
    });
  }

  void _gotoChooseMenu() {
    setState(() {
      inChooseMode = true;
    });
  }

  // Выбор карт персонажей
  void _selectCharacterCard(CardModel card) {
    if (selectedCharacterCards.contains(card)) {
      selectedCharacterCards.remove(card);
    } else if (selectedCharacterCards.length < 3) {
      selectedCharacterCards.add(card);
    }
    setState(() {});
  }

  // Выбор карт подмоги
  void _selectSupportCard(CardModel card) {
    if (selectedSupportCards.contains(card)) {
      selectedSupportCards.remove(card);
    } else if (selectedSupportCards.length < 2) {
      selectedSupportCards.add(card);
    }
    setState(() {});
  }

  void _selectActiveCard(PlayerModel player, CardModel card) {// TODO: выбор только для себя
    if (!card.isSupport && player == game!.player1) {
      game!.player1.activeCard = card;
      game!.player2.activeCard = card;
      setState(() {});
    }
  }

  void _dontInteract(CardModel card) {}

  void backToClassChoose() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
      setState(() {
        cardsSectionNum = 0;
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'syncopate'),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
        body: Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: 1080,
              height: 1920,
              child: inLobby ? _buildLobby() : _buildGame(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLobby() {
    return Stack(
      children: [
        Container(
          width: 1080,
          padding: const EdgeInsets.symmetric(
            horizontal: 110,
            vertical: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 124),
              SizedBox(
                height: 380,
                width: 1080,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 305,
                      width: 594,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 16, 16, 16),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(
                      height: 315,
                      width: 495,
                      child: SvgPicture.asset(
                        '../assets/images/logo.svg',
                        fit: BoxFit.contain
                      ),
                    ),
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(bottom: 15),
                        child: Text(
                          "БАЛДЕЖНЫЕ БИТВЫ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 104, 104, 104),
                            fontSize: 56.85,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 119),
              Container(
                width: 1080,
                margin: const EdgeInsets.only(
                  left: 25,
                  right: 35
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 25,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 16, 16, 16),
                        borderRadius: BorderRadius.circular(51),
                        border: Border.all(
                          color: const Color.fromARGB(255, 53, 53, 53),
                          width: 10,
                        ),
                        boxShadow: CustomBoxShadows.shadowOnDark
                      ),
                      width: 743,
                      child: Row(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Image.asset(
                                '../assets/images/missing_avatar.jpg',
                                width: 167.2,
                                height: 167.2,
                              ),
                              Container(
                                width: 199,
                                height: 199,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 134, 0, 255),
                                    width: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 40),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ВЛАД ЛАХТА",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 46.9,
                                  ),
                                ),
                                Text(
                                  "@lahta_vlad",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 104, 104, 104),
                                    fontSize: 31.15,
                                  )
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 51),//TODO: локачать шрифт потоньше
              const Stack(//rating
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Text(
                    "РЕЙТИНГ:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 47.5,
                    ),
                  ),
                  SizedBox(
                    width: 1080,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_rate,
                          color: Color.fromARGB(255, 134, 0, 255),
                          size: 183.79,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Text(
                              "1500",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 183.79,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              ),
              const SizedBox(height: 18),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BorderedSocket(radius: 4.59, height: 144.94, width: 93.27),
                  SizedBox(width: 26),
                  BorderedSocket(radius: 6.82, height: 215.64, width: 138.77),
                  SizedBox(width: 26),
                  BorderedSocket(radius: 6.82, height: 215.64, width: 138.77),
                  SizedBox(width: 26),
                  BorderedSocket(radius: 6.82, height: 215.64, width: 138.77),
                  SizedBox(width: 26),
                  BorderedSocket(radius: 4.59, height: 144.94, width: 93.27),
                ],
              ),
              const SizedBox(height: 65),
            ],
          ),
        ),
        SizedBox(
          height: 1920,
          width: 1080,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 176,
                top: 1583.86,
                height: 130.81,
                width: 417.44,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: CustomBoxShadows.shadowOnDark
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 134, 0, 255),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      shadowColor: const Color.fromARGB(98, 0, 0, 0),
                      elevation: 2,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: _gotoRools,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "ИГРАТЬ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 57
                          ),
                        )
                      ]
                    )
                  )
                ),
              ),
              ExpandablePanel(
                unload: backToClassChoose,
                background: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 57, 57, 57),
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: CustomBoxShadows.shadowOnDark
                  ),
                ),
                title: const Text(
                  "ИЗМЕНИТЬ\nСОСТАВ",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                content: Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          cardsSectionNum = 0;
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(),
                      ),
                    ),
                    FittedBox(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            cardsSectionNum = 0;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cardsSectionNum = 1;
                                    });
                                  },
                                  child: BorderedSocket(
                                    height: 250,
                                    width: 250,
                                    radius: 6,
                                    isBackBright: true,
                                    child: SvgPicture.asset(
                                      '../assets/images/icoSupport.svg',
                                      fit: BoxFit.contain
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 44,),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cardsSectionNum = 2;
                                    });
                                  },
                                  child: BorderedSocket(
                                    height: 250,
                                    width: 250,
                                    radius: 6,
                                    isBackBright: true,
                                    child: SvgPicture.asset(
                                      '../assets/images/icoDamagger.svg',
                                      fit: BoxFit.contain
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 44),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cardsSectionNum = 3;
                                    });
                                  },
                                  child: BorderedSocket(
                                    height: 250,
                                    width: 250,
                                    radius: 6,
                                    isBackBright: true,
                                    child: SvgPicture.asset(
                                      '../assets/images/icoHealer.svg',
                                      fit: BoxFit.contain
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 44,),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cardsSectionNum = 4;
                                    });
                                  },
                                  child: BorderedSocket(
                                    height: 250,
                                    width: 250,
                                    radius: 6,
                                    isBackBright: true,
                                    child: SvgPicture.asset(
                                      '../assets/images/icoShielder.svg',
                                      fit: BoxFit.contain
                                    ),
                                  ),
                                ),
                              ]
                            ),
                            const SizedBox(height: 44),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  cardsSectionNum = 5;
                                });
                              },
                              child: const BorderedSocket(
                                height: 180,
                                width: 544,
                                radius: 6,
                                isBackBright: true,
                                child: Text(
                                  "ПОДМОГА",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                    cardsSectionNum == 1 ?
                      ExpandablePanel (
                        minY: 215,
                        maxY: 215,
                        minX: 104,
                        maxX: 104,
                        minH: 250,
                        maxH: 792,
                        minW: 250,
                        maxW: 544,
                        minTO: 90,
                        maxTO: 50,
                        selfActivating: true,
                        unload: backToClassChoose,
                        background: const BorderedSocket(
                          radius: 6,
                          isBackBright: true
                        ),
                        title: SvgPicture.asset(
                          '../assets/images/icoSupport.svg',
                          fit: BoxFit.contain
                        ),
                        content: const ImageCarousel(
                          imageAssets: [
                            '../assets/cards/supports/Aksenov.png',
                            '../assets/cards/supports/Lahta.png',
                            '../assets/cards/supports/Leluh.png',
                            '../assets/cards/supports/Lopatkova.png',
                            '../assets/cards/supports/Nikolaeva.png',
                            '../assets/cards/supports/Pligun.png',
                            '../assets/cards/supports/Troshin.png',
                          ],
                          sectionNumber: 0,
                        ),
                      )
                    : cardsSectionNum == 2 ?
                      ExpandablePanel (
                        minY: 215,
                        maxY: 215,
                        minX: 104,
                        maxX: 396,
                        minH: 250,
                        maxH: 792,
                        minW: 250,
                        maxW: 544,
                        minTO: 90,
                        maxTO: 50,
                        selfActivating: true,
                        unload: backToClassChoose,
                        background: const BorderedSocket(
                          radius: 6,
                          isBackBright: true
                        ),
                        title: SvgPicture.asset(
                          '../assets/images/icoDamagger.svg',
                          fit: BoxFit.contain
                        ),
                        content: const ImageCarousel(
                          imageAssets: [
                            '../assets/cards/damaggers/Chizhova.png',
                            '../assets/cards/damaggers/Evstafeva.png',
                            '../assets/cards/damaggers/Fefelova.png',
                            '../assets/cards/damaggers/Koltsov.png',
                            '../assets/cards/damaggers/Levkin.png',
                            '../assets/cards/damaggers/Sirina.png',
                            '../assets/cards/damaggers/Son.png',
                          ],
                          sectionNumber: 1,
                        ),
                      )
                    : cardsSectionNum == 3 ?
                      ExpandablePanel (
                        minY: 215,
                        maxY: 509,
                        minX: 104,
                        maxX: 104,
                        minH: 250,
                        maxH: 792,
                        minW: 250,
                        maxW: 544,
                        minTO: 90,
                        maxTO: 50,
                        selfActivating: true,
                        unload: backToClassChoose,
                        background: const BorderedSocket(
                          radius: 6,
                          isBackBright: true
                        ),
                        title: SvgPicture.asset(
                          '../assets/images/icoHealer.svg',
                          fit: BoxFit.contain
                        ),
                        content: const ImageCarousel(
                          imageAssets: [
                            '../assets/cards/healers/Badmaev.png',
                            '../assets/cards/healers/Ledovskih.png',
                            '../assets/cards/healers/Permyakova.png',
                            '../assets/cards/healers/Ryabov.png',
                            '../assets/cards/healers/Sharipova.png',
                            '../assets/cards/healers/Shevnyakov.png',
                            '../assets/cards/healers/Zvezdakov.png',
                          ],
                          sectionNumber: 2,
                        ),
                      )
                    : cardsSectionNum == 4 ?
                      ExpandablePanel (
                        minY: 215,
                        maxY: 509,
                        minX: 104,
                        maxX: 396,
                        minH: 250,
                        maxH: 792,
                        minW: 250,
                        maxW: 544,
                        minTO: 80,
                        maxTO: 40,
                        selfActivating: true,
                        unload: backToClassChoose,
                        background: const BorderedSocket(
                          radius: 6,
                          isBackBright: true
                        ),
                        title: SvgPicture.asset(
                          '../assets/images/icoShielder.svg',
                          fit: BoxFit.contain
                        ),
                        content: const ImageCarousel(
                          imageAssets: [
                            '../assets/cards/shielders/Agafonov.png',
                            '../assets/cards/shielders/Arhipenkov.png',
                            '../assets/cards/shielders/Drofichev.png',
                            '../assets/cards/shielders/Fedorov.png',
                            '../assets/cards/shielders/Gorbunov.png',
                            '../assets/cards/shielders/Kucher.png',
                            '../assets/cards/shielders/Vorobyev.png',
                          ],
                          sectionNumber: 3,
                        ),
                      )
                    : cardsSectionNum == 5 ?
                      ExpandablePanel (
                        minY: 215,
                        maxY: 804,
                        minX: 104,
                        maxX: 104,
                        minH: 180,
                        maxH: 792,
                        minW: 544,
                        maxW: 544,
                        minTO: 75,
                        maxTO: 50,
                        selfActivating: true,
                        unload: backToClassChoose,
                        background: const BorderedSocket(
                          radius: 6,
                          isBackBright: true
                        ),
                        title: const Text(
                          "ПОДМОГА",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30
                          ),
                        ),
                        content: const ImageCarousel(
                          imageAssets: [
                            '../assets/cards/adders/Mansarda.png',
                            '../assets/cards/adders/MiM.png',
                            '../assets/cards/adders/SVP.png',
                            '../assets/cards/adders/TSh.png',
                          ],
                          sectionNumber: 4,
                        ),
                      )
                    : const SizedBox(),
                  ]
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Виджет карты
  Widget _buildCardWidget(CardModel card, bool isSelected, Function(CardModel) onTap) {
    return GestureDetector(
      onTap: () => onTap(card),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey), // Подсветка выбранной или активной карты
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Colors.blue.withOpacity(0.05) : null, // Дополнительная подсветка
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(card.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(card.cardClass, style: const TextStyle(fontStyle: FontStyle.italic)),
            if (!card.isSupport)
              Column(
                children: [
                  Text("Навык: ${card.skill}"),
                  Text("Ульта: ${card.ultimate}"),
                  Text("Пассивка: ${card.passiveSkill}"),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGame() {
    // TODO: Добавить сам игровой процесс
    return Stack(
      children: [
        // Карты второго игрока
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: _buildPlayerCards(game!.player2, _selectActiveCard),
        ),
        // объявление об этапе
        if (game!.player1.activeCard == null)
          const Center(
            child: Text("Выберите активного персонажа", style: TextStyle(fontSize: 30, color: Colors.blue)),
          ),
        // Карты первого игрока
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: _buildPlayerCards(game!.player1, _selectActiveCard),
        ),
      ],
    );
  }

  Widget _buildPlayerCards(PlayerModel player, Function(PlayerModel, CardModel) onTap) {
    return Center(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          if (game!.player1.activeCard == null && player == game!.player1) // можно выбрать активную карту от лица 1-го игрока, если она еще не выбрана
            Wrap(children: player.cards.map((card) => _buildCardWidget(card, player.activeCard == card, (card) => onTap(player, card))).toList())
          else
            Wrap(children: player.cards.map((card) => _buildCardWidget(card, player.activeCard == card, _dontInteract)).toList()),
        ],
      ),
    );
  }
}

void main() => runApp(CardGameApp());
