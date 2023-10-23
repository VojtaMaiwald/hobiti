part of 'game_cubit.dart';

class GameState {
  final List<PlayerEntity> players;

  GameState({
    required this.players,
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
  }) {
    return GameState(
      players: players ?? this.players,
    );
  }
}
