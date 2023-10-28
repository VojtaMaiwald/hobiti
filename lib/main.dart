import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobiti/button_painter.dart';
import 'package:hobiti/constants.dart';
import 'package:hobiti/cubit/game_cubit.dart';
import 'package:hobiti/player_card.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Widget _getPointButton(BuildContext context, bool positive, int points, List<bool> roundedCorners) {
    return GestureDetector(
      onTap: () {
        context.read<GameCubit>().addPoints(points);
      },
      child: SizedBox(
        width: Constants.pointsButtonWidth,
        height: Constants.pointsButtonHeight,
        child: CustomPaint(
          painter: ButtonPainter(
            positive: positive,
            borderRadius: Constants.borderRadiusSecondary,
            points: points,
            roundedCorners: roundedCorners,
          ),
        ),
      ),
    );
  }

  List<Widget> _getButtonsPortrait(BuildContext context) {
    return [
      _getPointButton(context, false, -1, [true, false, false, true]),
      _getPointButton(context, false, -5, [false, true, true, false]),
      Expanded(child: Container()),
      _getPointButton(context, true, 1, [true, false, false, true]),
      _getPointButton(context, true, 5, [false, false, false, false]),
      _getPointButton(context, true, 10, [false, true, true, false]),
      Expanded(child: Container()),
      FloatingActionButton(
        elevation: 0,
        backgroundColor: Constants.secondaryColor,
        onPressed: () {
          //TODO add player
        },
        child: const Icon(
          Icons.edit,
          color: Constants.primaryColor,
        ),
      ),
    ];
  }

  List<Widget> _getButtonsLandscape(BuildContext context) {
    return [
      FloatingActionButton(
        elevation: 0,
        backgroundColor: Constants.secondaryColor,
        onPressed: () {
          //TODO add player
        },
        child: const Icon(
          Icons.edit,
          color: Constants.primaryColor,
        ),
      ),
      Expanded(child: Container()),
      _getPointButton(context, true, 10, [true, true, false, false]),
      _getPointButton(context, true, 5, [false, false, false, false]),
      _getPointButton(context, true, 1, [false, false, true, true]),
      Expanded(child: Container()),
      _getPointButton(context, false, -5, [true, true, false, false]),
      _getPointButton(context, false, -1, [false, false, true, true]),
    ];
  }

  Widget _getPlayers() {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Wrap(
          children: state.players
              .map(
                (player) => PlayerCard(
                  player: player,
                ),
              )
              .toList(),
        );
      },
    );
  }

  ThemeData _getTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        background: Constants.backgoundColor,
        primary: Constants.primaryColor,
        secondary: Constants.secondaryColor,
        onPrimary: Constants.onPrimaryColor,
        onSecondary: Constants.onSecondaryColor,
        onBackground: Constants.onBackgoundColor,
        error: Constants.errorColor,
        onError: Constants.onErrorColor,
        brightness: Brightness.dark,
        surface: Constants.backgoundColor,
        onSurface: Constants.onBackgoundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return BlocProvider(
      create: (context) => GameCubit(),
      child: MaterialApp(
        theme: _getTheme(),
        home: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Wrap(
                  children: [
                    _getPlayers(),
                  ],
                ),
                Align(
                  alignment: isPortrait ? Alignment.bottomCenter : Alignment.topRight,
                  child: Container(
                    height: isPortrait ? Constants.bottomBarPortraitHeight : MediaQuery.of(context).size.height,
                    width: !isPortrait ? Constants.bottomBarLandscapeHeight : MediaQuery.of(context).size.width,
                    color: Constants.bottomBarColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isPortrait ? Constants.mainPadding : Constants.innerPadding,
                        vertical: isPortrait ? Constants.innerPadding : Constants.mainPadding,
                      ),
                      child: Builder(builder: (context) {
                        return isPortrait
                            ? Row(children: _getButtonsPortrait(context))
                            : Column(children: _getButtonsLandscape(context));
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
