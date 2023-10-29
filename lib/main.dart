import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobiti/constants.dart';
import 'package:hobiti/cubit/game_cubit.dart';
import 'package:hobiti/player_card.dart';
import 'package:hobiti/styles/button_border.dart';
import 'package:hobiti/styles/button_painter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Widget _getPointButton(BuildContext context, bool positive, int points, List<bool> roundedCorners) {
    return Stack(
      children: [
        RawMaterialButton(
          constraints: const BoxConstraints(
            maxWidth: Constants.pointsButtonWidth,
            maxHeight: Constants.pointsButtonHeight,
          ),
          shape: ButtonBorder(
            positive: positive,
            borderRadius: Constants.borderRadiusSecondary,
            points: points,
            colorScheme: Theme.of(context).colorScheme,
            roundedCorners: roundedCorners,
          ),
          onPressed: () {
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
                colorScheme: Theme.of(context).colorScheme,
                roundedCorners: roundedCorners,
              ),
            ),
          ),
        ),
      ],
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
      _getFAB(context),
    ];
  }

  FloatingActionButton _getFAB(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      onPressed: () {
        //TODO add player
      },
      child: Container(
        height: Constants.floatingActionButtonSize,
        width: Constants.floatingActionButtonSize,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(Constants.borderRadiusSecondary),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: Constants.borderWidth,
          ),
        ),
        child: Icon(
          Icons.edit,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  List<Widget> _getButtonsLandscape(BuildContext context) {
    return [
      _getFAB(context),
      Expanded(child: Container()),
      _getPointButton(context, true, 10, [true, true, false, false]),
      _getPointButton(context, true, 5, [false, false, false, false]),
      _getPointButton(context, true, 1, [false, false, true, true]),
      Expanded(child: Container()),
      _getPointButton(context, false, -5, [true, true, false, false]),
      _getPointButton(context, false, -1, [false, false, true, true]),
    ];
  }

  Widget _getPlayers(ColorScheme colorScheme) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Wrap(
          children: state.players
              .map(
                (player) => PlayerCard(player: player, colorScheme: colorScheme),
              )
              .toList(),
        );
      },
    );
  }

  ThemeData _getTheme(ColorScheme? darkDynamic) {
    return ThemeData(useMaterial3: true, colorScheme: darkDynamic);
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return BlocProvider(
      create: (context) => GameCubit(),
      child: DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          return MaterialApp(
            theme: _getTheme(darkDynamic),
            home: Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    Wrap(
                      children: [
                        Builder(
                          builder: (context) {
                            return _getPlayers(Theme.of(context).colorScheme);
                          },
                        ),
                      ],
                    ),
                    Align(
                      alignment: isPortrait ? Alignment.bottomCenter : Alignment.topRight,
                      child: Container(
                        height: isPortrait ? Constants.bottomBarPortraitHeight : MediaQuery.of(context).size.height,
                        width: !isPortrait ? Constants.bottomBarLandscapeHeight : MediaQuery.of(context).size.width,
                        color: darkDynamic?.onInverseSurface ?? Constants.bottomBarColor,
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
          );
        },
      ),
    );
  }
}
