import 'package:farm/game/game.dart';
import 'package:farm/widgets/action_panel.dart';
import 'package:farm/widgets/user_panel.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Positioned.fill(child: GameWidget(game: FarmGame())),
        const UserPanel(),
        const Align(
          alignment: Alignment.bottomCenter,
          child: ActionPanel(),
        )
      ],
    );
  }
}
