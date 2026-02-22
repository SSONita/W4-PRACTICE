import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType { red, blue, yellow, green }

final colorService = ColorService();

class ColorService extends ChangeNotifier {
  int _redTapCount = 0;
  int _blueTapCount = 0;
  int _yellowTapCount = 0;
  int _greenTapCoount = 0;

  int get redTapCount => _redTapCount;
  int get blueTapCount => _blueTapCount;
  int get yellowTapCount => _yellowTapCount;
  int get greenTapCount => _greenTapCoount;

  void increment(CardType type) {
    if (type == CardType.red) {
      _redTapCount++;
    } else if (type == CardType.blue) {
      _blueTapCount++;
    } else if (type == CardType.yellow) {
      _yellowTapCount++;
    } else {
      _greenTapCoount++;
    }
    notifyListeners();
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0 ? ColorTapsScreen() : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: ListenableBuilder(
        listenable: colorService,
        builder: (context, _) {
          return Column(
            children: [
              ColorTap(type: CardType.red, tapCount: colorService.redTapCount),
              ColorTap(
                type: CardType.yellow,
                tapCount: colorService.yellowTapCount,
              ),
              ColorTap(
                type: CardType.green,
                tapCount: colorService.greenTapCount,
              ),
              ColorTap(
                type: CardType.blue,
                tapCount: colorService.blueTapCount,
              ),
            ],
          );
        },
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;
  final int tapCount;

  const ColorTap({super.key, required this.type, required this.tapCount});

  Color get backgroundColor {
    switch (type) {
      case CardType.red:
        return Colors.red;
      case CardType.blue:
        return Colors.blue;
      case CardType.yellow:
        return Colors.yellow;
      case CardType.green:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => colorService.increment(type),
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: ListenableBuilder(
        listenable: colorService,
        builder: (context, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Red Taps: ${colorService.redTapCount}',
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  'Yellow Taps: ${colorService.yellowTapCount}',
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  'Green Taps: ${colorService.greenTapCount}',
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  'Blue Taps: ${colorService.blueTapCount}',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
