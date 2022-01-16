import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class CompleteText extends StatelessWidget {
  const CompleteText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context).settings.arguments;

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
      home: const MyHomePage(title: 'Complete Text'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SpeechToText stt = SpeechToText();
  bool isListening = false;
  String text = '';
  //String original_metin = 'Yaşanan kış mevsiminin ardından gelen bahar beraberinde rengarenk çiçekleri de getirmiş. Çiçeklerin açması en çok bal yapan arıları mutlu etmiş. Vakit kaybetmeden çiçekten çiçeğe konarak yapacakları bal için çiçek özü toplamaya başlamışlar. Topladıkları özlerden yaptıkları balları çeşitli şekiller vererek kovanlara yerleştirmişler. Her şey güzel giderken birden ortaya yaban arıları çıkmış. Bu arılar bal arılarının yaptığı balların kendilerine ait olduğunu iddia etmişler. Bunun üzerine arılar arasında kavga başlamış.';
  String original_metin =
      "This message was kindly provided by my friend, John Rayment. You can find him on Twitter here. Transcript Welcome to Easy Stories in English, the podcast that will take your English from OK to Good, and from Good to Great.";
  double accuracy = 1.0;

  @override
  void initState() {
    initializeAudio();
    super.initState();
  }

  initializeAudio() async {
    stt.initialize();
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          reverse: true,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                child: Text(original_metin),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                child: Text(text),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: const Text(
                "Analys and save record.",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                //Nothing
              },
            ),
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: _listen,
        tooltip: 'Increment',
        child: Icon((isListening
            ? Icons.pause_circle_filled
            : Icons.play_circle_filled)),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _listen() async {
    if (stt.isAvailable) {
      if (!isListening) {
        stt.listen(onResult: (result) {
          setState(() {
            accuracy = result.confidence;
            text = result.recognizedWords;
            print('accuracy is $accuracy');
            isListening = true;
          });
        });
      } else {
        setState(() {
          isListening = false;
          stt.stop();
        });
      }
    } else {
      print('permission was denied');
    }
  }
}
