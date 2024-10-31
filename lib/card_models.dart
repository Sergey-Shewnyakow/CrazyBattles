// Модель карты
class CardModel {
  String name;
  String asset;
  int health;
  int shield;
  String cardClass;
  String skill;
  String ultimate;
  String passiveSkill;
  bool isAssist;
  int infoPage;

  CardModel({
    required this.name,
    required this.asset,
    this.health = 10,
    this.shield = 0,
    required this.cardClass,
    this.skill = "",
    this.ultimate = "",
    this.passiveSkill = "",
    this.isAssist = false,
    required this.infoPage,
  });
}

// Карты персонажей
List<CardModel> characterCards = [
  CardModel(name: "Роман Аксенов", asset: 'cards/supports/Aksenov.png', infoPage: 21, cardClass: "Саппорт", skill: "Поиск слушателей", ultimate: "Скороговорка", passiveSkill: "Ловкая махинация"),
  CardModel(name: "Владислав Лайхтман", asset: 'cards/supports/Lahta.png', infoPage: 17, cardClass: "Саппорт", skill: "ПП-шечка", ultimate: "Трудности саппорта", passiveSkill: "Модный приговор"),
  CardModel(name: "Ксения Лелюх", asset: 'cards/supports/Leluh.png', infoPage: 16, cardClass: "Саппорт", skill: "Вор очаровашка", ultimate: "Пуленепробиваемость", passiveSkill: "Каждый сам за себя"),
  CardModel(name: "Алеся Лопаткова", asset: 'cards/supports/Lopatkova.png', infoPage: 19, cardClass: "Саппорт", skill: "Дубайский подарок", ultimate: "Мышеловка", passiveSkill: "Сила дружбы"),
  CardModel(name: "Мария Николаева", asset: 'cards/supports/Nikolaeva.png', infoPage: 22, cardClass: "Саппорт", skill: "Дизайнерское решение", ultimate: "Изысканный вкус", passiveSkill: "Помощь ближнему"),
  CardModel(name: "Диана Плыгун", asset: 'cards/supports/Pligun.png', infoPage: 18, cardClass: "Саппорт", skill: "Ты в тренде", ultimate: "Роковая улыбка", passiveSkill: "Вечно в тонусе"),
  CardModel(name: "Никита Трошин", asset: 'cards/supports/Troshin.png', infoPage: 20, cardClass: "Саппорт", skill: "Вести за собой", ultimate: "Perfecto", passiveSkill: "Помощь на века"),
  CardModel(name: "Анастасия Чижова", asset: 'cards/damaggers/Chizhova.png', infoPage: 26, cardClass: "Дамаггер", skill: "Надменный жест", ultimate: "Полная антисанитария", passiveSkill: "Травля"),
  CardModel(name: "Полина Евстафьева", asset: 'cards/damaggers/Evstafeva.png', infoPage: 28, cardClass: "Дамаггер", skill: "Тебя к телефону", ultimate: "Время - деньги", passiveSkill: "Лёгкое усиление"),
  CardModel(name: "Софья Фефелова", asset: 'cards/damaggers/Fefelova.png', infoPage: 23, cardClass: "Дамаггер", skill: "Больше пресса", ultimate: "Ну и кадр!", passiveSkill: "По образу и подобию"),
  CardModel(name: "Денис Кольцов", asset: 'cards/damaggers/Koltsov.png', infoPage: 24, cardClass: "Дамаггер", skill: "Око за око", ultimate: "Токсичность", passiveSkill: "Легкая добыча"),
  CardModel(name: "Михаил Лёвкин", asset: 'cards/damaggers/Levkin.png', infoPage: 25, cardClass: "Дамаггер", skill: "Бальный бумеранг", ultimate: "Танец смерти", passiveSkill: "Искра разрушения"),
  CardModel(name: "Анастасия Сирина", asset: 'cards/damaggers/Sirina.png', infoPage: 27, cardClass: "Дамаггер", skill: "Лидер долгов", ultimate: "Неизвестность", passiveSkill: "Расширение территории"),
  CardModel(name: "Эдвард Сон", asset: 'cards/damaggers/Son.png', infoPage: 29, cardClass: "Дамаггер", skill: "Музыкальная лотерея", ultimate: "Идеальное звучание", passiveSkill: "Нотный разлад"),
  CardModel(name: "Владислав Бадмаев", asset: 'cards/healers/Badmaev.png', infoPage: 34, cardClass: "Хиллер", skill: "Сладкоешка", ultimate: "Беречь до последнего", passiveSkill: "Поняшимся?"),
  CardModel(name: "Артём Ледовских", asset: 'cards/healers/Ledovskih.png', infoPage: 30, cardClass: "Хиллер", skill: "Мальчик, который выжил", ultimate: "Иллюзия века", passiveSkill: "Помощь друга"),
  CardModel(name: "Полина Пермякова", asset: 'cards/healers/Permyakova.png', infoPage: 36, cardClass: "Хиллер", skill: "Кошачья лапка", ultimate: "Мурчащая мелодия", passiveSkill: "Девять жизней"),
  CardModel(name: "Даниил Рябов", asset: 'cards/healers/Ryabov.png', infoPage: 35, cardClass: "Хиллер", skill: "Приказ", ultimate: "Капитан корабля", passiveSkill: "Сила воли"),
  CardModel(name: "Руфина Шарипова", asset: 'cards/healers/Sharipova.png', infoPage: 33, cardClass: "Хиллер", skill: "Сплетня", ultimate: "Сладкая подмога", passiveSkill: "Крепкий орешек"),
  CardModel(name: "Сергей Шевняков", asset: 'cards/healers/Shevnyakov.png', infoPage: 31, cardClass: "Хиллер", skill: "Кнут и пряник", ultimate: "Подмена", passiveSkill: "Исцеляющая легкость"),
  CardModel(name: "Александр Звездаков", asset: 'cards/healers/Zvezdakov.png', infoPage: 32, cardClass: "Хиллер", skill: "Мемология", ultimate: "Душевное равновесие", passiveSkill: "Сила господа"),
  CardModel(name: "Данил Агафонов", asset: 'cards/shielders/Agafonov.png', infoPage: 41, cardClass: "Щитовик", skill: "Удар по больному", ultimate: "Бьёшь, как девчонка", passiveSkill: "Кешбэк"),
  CardModel(name: "Даниил Архипенков", asset: 'cards/shielders/Arhipenkov.png', infoPage: 42, cardClass: "Щитовик", skill: "Легендарные строки", ultimate: "Вечеринка с бассейном", passiveSkill: "Помощь слабым"),
  CardModel(name: "Михаил Дрофичев", asset: 'cards/shielders/Drofichev.png', infoPage: 39, cardClass: "Щитовик", skill: "Если драка неизбежна...", ultimate: "Любимчик", passiveSkill: "Копилка"),
  CardModel(name: "Денис Федоров", asset: 'cards/shielders/Fedorov.png', infoPage: 37, cardClass: "Щитовик", skill: "Один вам, один мне", ultimate: "Всё на кон", passiveSkill: "Чувство меры"),
  CardModel(name: "Владислав Горбунов", asset: 'cards/shielders/Gorbunov.png', infoPage: 40, cardClass: "Щитовик", skill: "Опасные игры", ultimate: "Лютая защита", passiveSkill: "Зеркало"),
  CardModel(name: "Дарья Кучер", asset: 'cards/shielders/Kucher.png', infoPage: 43, cardClass: "Щитовик", skill: "Позитивный настрой", ultimate: "+вайб", passiveSkill: "Заряд энергии"),
  CardModel(name: "Филипп Воробьев", asset: 'cards/shielders/Vorobyev.png', infoPage: 38, cardClass: "Щитовик", skill: "Беззвучный режим", ultimate: "Терпит-терпит, а потом терпит-терпит", passiveSkill: "Бывалый"),
];

// Карты подмоги
List<CardModel> assistCards = [
  CardModel(name: "Мансарда", asset: 'cards/adders/Mansarda.png', infoPage: 45, cardClass: "Постоянная", isAssist: true),
  CardModel(name: "МиМ", asset: 'cards/adders/MiM.png', infoPage: 44, cardClass: "Периодическая", isAssist: true),
  CardModel(name: "СВП", asset: 'cards/adders/SVP.png', infoPage: 47, cardClass: "Периодическая", isAssist: true),
  CardModel(name: "Твоё шоу", asset: 'cards/adders/TSh.png', infoPage: 46, cardClass: "Постоянная", isAssist: true),
];

// Выбранные карты
List<CardModel> selectedCharacterCards = [];
List<CardModel> selectedAssistCards = [];