import 'package:flutter/material.dart';

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
  CardModel(name: "Софья Фефелова", cardClass: "Дамаггер", skill: "Больше пресса", ultimate: "Ну и кадр!", passiveSkill: "По образу и подобию"),
  CardModel(name: "Денис Кольцов", cardClass: "Дамаггер", skill: "Око за око", ultimate: "Токсичность", passiveSkill: "Легкая добыча"),
  CardModel(name: "Михаил Лёвкин", cardClass: "Дамаггер", skill: "Бальный бумеранг", ultimate: "Танец смерти", passiveSkill: "Искра разрушения"),
  CardModel(name: "Анастасия Чижова", cardClass: "Дамаггер", skill: "Надменный жест", ultimate: "Полная антисанитария", passiveSkill: "Травля"),
  CardModel(name: "Анастасия Сирина", cardClass: "Дамаггер", skill: "Лидер долгов", ultimate: "Неизвестность", passiveSkill: "Расширение территории"),
  CardModel(name: "Полина Евстафьева", cardClass: "Дамаггер", skill: "Тебя к телефону", ultimate: "Время - деньги", passiveSkill: "Лёгкое усиление"),
  CardModel(name: "Эдвард Сон", cardClass: "Дамаггер", skill: "Музыкальная лотерея", ultimate: "Идеальное звучание", passiveSkill: "Нотный разлад"),
  CardModel(name: "Денис Федоров", cardClass: "Щитовик", skill: "Один вам, один мне", ultimate: "Всё на кон", passiveSkill: "Чувство меры"),
  CardModel(name: "Филипп Воробьев", cardClass: "Щитовик", skill: "Беззвучный режим", ultimate: "Терпит-терпит, а потом терпит-терпит", passiveSkill: "Бывалый"),
  CardModel(name: "Михаил Дрофичев", cardClass: "Щитовик", skill: "Если драка неизбежна...", ultimate: "Любимчик", passiveSkill: "Копилка"),
  CardModel(name: "Владислав Горбунов", cardClass: "Щитовик", skill: "Опасные игры", ultimate: "Лютая защита", passiveSkill: "Зеркало"),
  CardModel(name: "Данил Агафонов", cardClass: "Щитовик", skill: "Удар по больному", ultimate: "Бьёшь, как девчонка", passiveSkill: "Кешбэк"),
  CardModel(name: "Даниил Архипенков", cardClass: "Щитовик", skill: "Легендарные строки", ultimate: "Вечеринка с бассейном", passiveSkill: "Помощь слабым"),
  CardModel(name: "Дарья Кучер", cardClass: "Щитовик", skill: "Позитивный настрой", ultimate: "+вайб", passiveSkill: "Заряд энергии"),
  CardModel(name: "Артём Ледовских", cardClass: "Хиллер", skill: "Мальчик, который выжил", ultimate: "Иллюзия века", passiveSkill: "Помощь друга"),
  CardModel(name: "Сергей Шевняков", cardClass: "Хиллер", skill: "Кнут и пряник", ultimate: "Подмена", passiveSkill: "Исцеляющая легкость"),
  CardModel(name: "Александр Звездаков", cardClass: "Хиллер", skill: "Мемология", ultimate: "Душевное равновесие", passiveSkill: "Сила господа"),
  CardModel(name: "Руфина Шарипова", cardClass: "Хиллер", skill: "Сплетня", ultimate: "Сладкая подмога", passiveSkill: "Крепкий орешек"),
  CardModel(name: "Владислав Бадмаев", cardClass: "Хиллер", skill: "Сладкоешка", ultimate: "Беречь до последнего", passiveSkill: "Поняшимся?"),
  CardModel(name: "Даниил Рябов", cardClass: "Хиллер", skill: "Приказ", ultimate: "Капитан корабля", passiveSkill: "Сила воли"),
  CardModel(name: "Полина Пермякова", cardClass: "Хиллер", skill: "Кошачья лапка", ultimate: "Мурчащая мелодия", passiveSkill: "Девять жизней"),
  CardModel(name: "Ксения Лелюх", cardClass: "Саппорт", skill: "Вор очаровашка", ultimate: "Пуленепробиваемость", passiveSkill: "Каждый сам за себя"),
  CardModel(name: "Владислав Лайхтман", cardClass: "Саппорт", skill: "ПП-шечка", ultimate: "Трудности саппорта", passiveSkill: "Модный приговор"),
  CardModel(name: "Диана Плыгун", cardClass: "Саппорт", skill: "Ты в тренде", ultimate: "Роковая улыбка", passiveSkill: "Вечно в тонусе"),
  CardModel(name: "Алеся Лопаткова", cardClass: "Саппорт", skill: "Дубайский подарок", ultimate: "Мышеловка", passiveSkill: "Сила дружбы"),
  CardModel(name: "Никита Трошин", cardClass: "Саппорт", skill: "Вести за собой", ultimate: "Perfecto", passiveSkill: "Помощь на века"),
  CardModel(name: "Роман Аксенов", cardClass: "Саппорт", skill: "Поиск слушателей", ultimate: "Скороговорка", passiveSkill: "Ловкая махинация"),
  CardModel(name: "Мария Николаева", cardClass: "Саппорт", skill: "Дизайнерское решение", ultimate: "Изысканный вкус", passiveSkill: "Помощь ближнему"),
];

// Карты подмоги
List<CardModel> supportCards = [
  CardModel(name: "МиМ", cardClass: "Периодическая", isSupport: true),
  CardModel(name: "Мансарда", cardClass: "Постоянная", isSupport: true),
  CardModel(name: "Твоё шоу", cardClass: "Постоянная", isSupport: true),
  CardModel(name: "СВП", cardClass: "Периодическая", isSupport: true),
];

// Виджет игры
class CardGameApp extends StatefulWidget {
  @override
  _CardGameAppState createState() => _CardGameAppState();
}

class _CardGameAppState extends State<CardGameApp> {
  GameModel? game;
  bool inLobby = true;
  bool inCardChooser = false;

  // Выбранные карты
  List<CardModel> selectedCharacterCards = [];
  List<CardModel> selectedSupportCards = [];

  // Инициализация игры
  void _initializeGame() {
    setState(() {
      inLobby = false;
      inCardChooser = true;
    });
  }

  // Запуск игры с выбранными картами
  void _startGame(List<CardModel> characterCards, List<CardModel> supportCards) {
    game = GameModel(
      player1: PlayerModel(name: "Игрок 1", cards: characterCards + supportCards),
      player2: PlayerModel(name: "Игрок 2", cards: characterCards + supportCards),// TODO: выдача игрокам выбранных ими карт
    );
    setState(() {
      inLobby = false;
      inCardChooser = false;
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: inLobby ? _buildLobby() : inCardChooser ? _buildGameStart() : _buildGame(),
      ),
    );
  }

  Widget _buildLobby() {
    return Center(
      child: ElevatedButton(
        onPressed: _initializeGame,
        child: const Text("Начать игру"),
      ),
    );
  }

  Widget _buildGameStart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Выберите 3 карты персонажей и до 2 карт подмоги", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          // Выбор персонажей
          const Text("Персонажи:", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: characterCards.map((card) => _buildCardWidget(card, selectedCharacterCards.contains(card) || selectedSupportCards.contains(card), _selectCharacterCard)).toList(),
          ),
          const SizedBox(height: 20),
          // Выбор подмоги
          const Text("Подмога:", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: supportCards.map((card) => _buildCardWidget(card, selectedCharacterCards.contains(card) || selectedSupportCards.contains(card), _selectSupportCard)).toList(),
          ),
          const SizedBox(height: 20),
          // Кнопка подтверждения выбора
          ElevatedButton(
            onPressed: selectedCharacterCards.length == 3 && selectedSupportCards.length <= 2
                ? () {
                    _startGame(selectedCharacterCards, selectedSupportCards);
                  }
                : null,
            child: const Text("Подтвердить выбор"),
          ),
        ],
      ),
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
