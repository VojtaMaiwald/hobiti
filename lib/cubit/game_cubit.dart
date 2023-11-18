import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobiti/entities/player_entity.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameState.initial());

  TextEditingController controller = TextEditingController();

  void selectPlayer(String id) {
    emit(
      state.copyWith(
        players: state.players.map((e) {
          if (e.id == id) {
            return e.copyWith(selected: !e.selected);
          } else {
            return e.copyWith(selected: false);
          }
        }).toList(),
      ),
    );
  }

  void addPoints(int points) {
    emit(
      state.copyWith(
        players: state.players.map((e) {
          if (e.selected) {
            return e.copyWith(points: max(min(e.points + points, 999), 0));
          } else {
            return e;
          }
        }).toList(),
      ),
    );
  }

  void addPlayer() {
    emit(
      state.copyWith(
        players: [
          ...state.players,
          PlayerEntity(
            id: (DateTime.now().millisecondsSinceEpoch + state.players.length).toRadixString(36),
            name: state.tempPlayerName,
            points: 0,
            selected: false,
          ),
        ],
      ),
    );
    controller.clear();
  }

  void removePlayer(String id) {
    emit(
      state.copyWith(
        players: state.players.where((element) => element.id != id).toList(),
      ),
    );
  }

  void setTempPlayerName(String name) {
    emit(
      state.copyWith(
        tempPlayerName: name,
      ),
    );
  }
}
