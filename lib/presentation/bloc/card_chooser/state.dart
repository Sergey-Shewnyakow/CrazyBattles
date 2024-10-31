import '../../widget/lobby_widgets/BLoC-less/card_slot.dart';
import '../../widget/lobby_widgets/card_chooser.dart'; //slot for card in menu

class ChooserState {
  final int cardsSectionNum;
  final List<Slot> slots;
  final int forcedExpansion;// 2 - forced expand, -2 - forced shrink
  final CardChooser thisWidget;

  const ChooserState({
    required this.cardsSectionNum,
    required this.slots,
    required this.forcedExpansion,
    required this.thisWidget,
  });
}