import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parallax Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(body: Parallax()),
    );
  }
}

class Parallax extends StatefulWidget {
  const Parallax({Key? key}) : super(key: key);

  @override
  State<Parallax> createState() => _ParallaxState();
}

class _ParallaxState extends State<Parallax> {
  late PageController _pageController;
  late double _pageOffset;

  @override
  void initState() {
    super.initState();
    _pageOffset = 0;
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(
        () => setState(() => _pageOffset = _pageController.page ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(
          pageCount: screens.length + 1,
          screenSize: MediaQuery.of(context).size,
          offset: _pageOffset,
        ),
        PageView(
          controller: _pageController,
          children: [
            ...screens
                .map((screen) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.black.withOpacity(0.4),
                  child: Text(
                    screen.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.black.withOpacity(0.4),
                  child: Text(
                    screen.body,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ))
                .toList(),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
    required this.pageCount,
    required this.screenSize,
    required this.offset,
  }) : super(key: key);

  final Size screenSize;
  final int pageCount;
  final double offset;

  @override
  Widget build(BuildContext context) {
    int lastPageIdx = pageCount - 1;
    int firstPageIdx = 0;
    int alignmentMax = 1;
    int alignmentMin = -1;
    int pageRange = (lastPageIdx - firstPageIdx) - 1;
    int alignmentRange = (alignmentMax - alignmentMin);
    double alignment =
        (((offset - firstPageIdx) * alignmentRange) / pageRange) + alignmentMin;

    return SizedBox(
      height: screenSize.height,
      width: screenSize.width,
      child: Image(
        image: const AssetImage('assets/tokyo-street-pano.jpg'),
        alignment: Alignment(alignment, 0),
        fit: BoxFit.fitHeight,
      ),
    );
  }
}

class Screen {
  const Screen({required this.title, required this.body});

  final String title;
  final String body;
}

const List<Screen> screens = [
  Screen(title: '夜', body: 'Night'),
  Screen(title: '通り', body: 'Street'),
  Screen(title: 'ネオン', body: 'Neon sign'),
  Screen(title: '舗', body: 'Store'),
  Screen(title: '東京', body: 'Tokyo'),
  Screen(title: '夜', body: 'Night'),
  Screen(title: '通り', body: 'Street'),
  Screen(title: 'ネオン', body: 'Neon sign'),
  Screen(title: '舗', body: 'Store'),
  Screen(title: '東京', body: 'Tokyo'),
];
