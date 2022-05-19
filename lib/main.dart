import 'package:desktop_window/desktop_window.dart';
import 'package:farm/global.dart';
import 'package:farm/widgets/action_panel.dart';
import 'package:farm/widgets/user_panel.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  await DesktopWindow.setWindowSize(const Size(920, 720));
  await DesktopWindow.setMaxWindowSize(const Size(920, 720));
  await DesktopWindow.setMinWindowSize(const Size(920, 720));
  await Flame.images.load('floors.png');
  await Flame.images.load('btns.png');
  await Flame.images.load('seeds.png');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: GameScrollBehavior(),
        home: Scaffold(
          body: Stack(
            alignment: Alignment.topLeft,
            children: [
              Positioned.fill(child: GameWidget(game: Global.game)),
              const UserPanel(),
              const Align(
                alignment: Alignment.bottomCenter,
                child: ActionPanel(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
