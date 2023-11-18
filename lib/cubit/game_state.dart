part of 'game_cubit.dart';

class GameState {
  final List<PlayerEntity> players;
  final String tempPlayerName;

  GameState({
    required this.players,
    this.tempPlayerName = "",
  });

  factory GameState.initial() {
    return GameState(
      players: List.generate(8, (index) {
        return PlayerEntity(
          id: (DateTime.now().millisecondsSinceEpoch + index).toRadixString(36),
          name: (DateTime.now().millisecondsSinceEpoch + index).toRadixString(36),
          points: index,
          selected: false,
        );
      }),
    );
  }

  GameState copyWith({
    List<PlayerEntity>? players,
    String? tempPlayerName,
  }) {
    return GameState(
      players: players ?? this.players,
      tempPlayerName: tempPlayerName ?? this.tempPlayerName,
    );
  }
}
