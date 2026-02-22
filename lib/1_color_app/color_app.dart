import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType {
  red(Colors.red),
  yellow(Colors.yellow),
  green(Colors.green),
  blue(Colors.blue);

  final Color color;
  const CardType(this.color);
}

final colorService = ColorService();

class ColorService extends ChangeNotifier {
  final Map<CardType, int> _tapCount = {
    for (var type in CardType.values) type: 0,
  };

  int getTapCount(CardType type) => _tapCount[type]!;

  void increment(CardType type) {
    _tapCount[type] = _tapCount[type]! + 1;
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
            children: CardType.values.map((type) {
              return ColorTap(
                type: type,
                tapCount: colorService.getTapCount(type),
              );
            }).toList(),
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

  Color get backgroundColor => type.color;

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
              children: CardType.values.map((type) {
                return Text(
                  '${type.name} Taps: ${colorService.getTapCount(type)}',
                  style: TextStyle(fontSize: 24),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
