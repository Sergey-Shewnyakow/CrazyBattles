class OpponentSearchState {
  final DateTime timeStart;
  final String timeStopwatch;
  final bool isTimerStarted;

  const OpponentSearchState({
    required this.timeStart,
    this.timeStopwatch = "0:00",
    this.isTimerStarted = false,
  });
}