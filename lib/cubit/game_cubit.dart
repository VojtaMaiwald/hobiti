import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobiti/Entities/player_entity.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameState.initial());

  void selectPlayer(String id) {
    emit(state.copyWith(
      players: state.players.map((e) {
        if (e.id == id) {
          return e.copyWith(selected: !e.selected);
        } else {
          return e.copyWith(selected: false);
        }
      }).toList(),
    ));
  }

  void addPoints(int points) {
    emit(state.copyWith(
      players: state.players.map((e) {
        if (e.selected) {
          return e.copyWith(points: max(min(e.points + points, 999), 0));
        } else {
          return e;
        }
      }).toList(),
    ));
  }
}
