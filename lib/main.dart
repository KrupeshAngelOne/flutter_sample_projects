import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'journey_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MigrationPagerWidget(title: 'Flutter Demo Home Page'),
    );
  }
}

class MigrationPagerWidget extends StatefulWidget {
  const MigrationPagerWidget({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MigrationPagerWidget> createState() => _MigrationPagerWidgetState();
}

int selectedIndex = 0;
final PageController controller = PageController();
double percent = 0;
List<JourneyItemData> list = [];
var item1 = JourneyItemData.createNew("One", "jsons/intro.json", "", "");
var item2 = JourneyItemData.createNew("Two", "jsons/watchlist.json", "", "");
var item3 = JourneyItemData.createNew("Three", "jsons/intro.json", "", "");

class _MigrationPagerWidgetState extends State<MigrationPagerWidget> {
  @override
  initState() {
    super.initState();
    // Add listeners to this class
    list.add(item1);
    list.add(item2);
    list.add(item3);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MigrationPagerWidget object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Stack(
          children: <Widget>[
            PageView.builder(
              itemBuilder: (context, index) {
                return pagerItem(list[index]);
              },
              itemCount: list.length,
              controller: controller,
              onPageChanged: (int page) {
                setState(() {
                  selectedIndex = page;
                });
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                      child: Text('${selectedIndex + 1}/${list.length}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.green),
                        width: 280,
                        child: LinearProgressIndicator(
                          value: (selectedIndex + 1) / list.length,
                          minHeight: 4,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.deepOrange),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                      child: getConditionalText(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

Widget getConditionalText() {
  if (selectedIndex + 1 == list.length) {
    return InkWell(onTap: () {}, child: const Text('FINISH'));
  } else {
    return InkWell(
        onTap: () {
          nextPage();
        },
        child: const Text('SKIP'));
  }
}

Widget pagerItem(JourneyItemData item) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      /*Text('Page ${item.title}'),*/
      Expanded(child: Lottie.asset(item.url, repeat: false)),
    ],
  );
}

void nextPage() {
  controller.animateToPage(controller.page!.toInt() + 1,
      duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
}

void previousPage() {
  controller.animateToPage(controller.page!.toInt() - 1,
      duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
}
