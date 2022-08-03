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
        primarySwatch: Colors.blue,
      ),
      home: const MigrationPagerWidget(title: 'Flutter Demo Home Page'),
    );
  }
}

class MigrationPagerWidget extends StatefulWidget {
  const MigrationPagerWidget({Key? key, required this.title}) : super(key: key);

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
    return Scaffold(
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
        /*Align(
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
        )*/
      ],
    ));
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
      Expanded(child: Lottie.asset(item.url, repeat: false, fit: BoxFit.fill)),
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
