import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bordered_text/bordered_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      title: "Max's Departure Planner",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int pageCounter = 5000;
  int startCounter = 2500;
  int currentPage = 2500;

  Widget getWidget(String text, bool highlight) {
    double pd = 8;
    if(highlight) {
      pd = 2;
    }

    Color bcolor = Color.fromARGB(0, 0, 180, 0);
    if(text == "25") {
      bcolor = Color.fromARGB(255, 219, 102, 71);
    }

    if(highlight) {
      return new FittedBox(
          fit: BoxFit.contain,
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: bcolor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child:Padding(
                  padding: EdgeInsets.all(pd),
                  child: BorderedText(
                    strokeWidth: 0.0,
                    strokeColor: Color.fromARGB(70,0,0,0),
                    child: Text(
                        text,
                        style: TextStyle(
                          color: Color.fromARGB(255, 250, 248, 221),
                        )),
                  )
              )
          ));
    }

    return new FittedBox(
          fit: BoxFit.contain,
          child:Padding(
            padding: EdgeInsets.all(pd),
            child: BorderedText(
              strokeWidth: 0.0,
              strokeColor: Color.fromARGB(70,0,0,0),
              child: Text(
              text,
              style: TextStyle(
                color: Color.fromARGB(255, 250, 248, 221),
              )),
          )
            )
        );
  }

  List<Widget> getWidgets(int current) {
    List<String> nums = ["05", "05", "25"];
    List<Widget> widgets = new List();
    for(int i = 0;i<pageCounter;i++) {
      widgets.add(getWidget(nums[i%3], (i == current)));
    }
    return widgets;
  }


  onPageViewChange(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {

    final controller = PageController(
      initialPage: startCounter,
      viewportFraction: 0.4,
    );
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var pg = getWidgets(currentPage);
    return new Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/water.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Container(
                  constraints: BoxConstraints(minWidth: 100, maxWidth: 300),
                  child: Image.asset("images/krewert.png")),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                new ConstrainedBox(
                  constraints:
                      new BoxConstraints(minHeight: 60.0, maxHeight: 400.0),
                  child: PageView(
                    controller: controller,
                    onPageChanged: onPageViewChange,
                    allowImplicitScrolling: false,
                    pageSnapping: true,
                    children: pg,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
