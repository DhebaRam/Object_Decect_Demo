// import 'dart:io';
//
// import 'package:face_camera/face_camera.dart';
// import 'package:flutter/material.dart';
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized(); //Add this
//   await FaceCamera.initialize(); //Add this
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SmartFaceCamera(
//           autoCapture: true,
//           defaultCameraLens: CameraLens.front,
//           message: 'Center your face in the square',
//           onCapture: (File? image){
//             print("Capture Image Face ----> ${image?.path}");
//           },
//         )
//     );
//   }
// }

import 'dart:async';
import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'home.dart';
import 'dart:isolate';

import 'local_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());

  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelGroupKey: 'reminders',
        channelKey: 'instant_notification',
        channelName: 'Basic Instant Notification',
        channelDescription: 'Testing Notification')
  ]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isolate Demo',
      home: IsolateDemo(),
    );
  }
}

class IsolateDemo extends StatefulWidget {
  @override
  IsolateDemoState createState() => IsolateDemoState();
}

class IsolateDemoState extends State<IsolateDemo> {
  int _counter = 0;

  // Method to increment the counter in a separate isolate
  Future<void> _incrementCounter() async {
    ReceivePort receivePort = ReceivePort();
    Isolate isolate =
        await Isolate.spawn(_isolateEntryPoint, receivePort.sendPort);

    receivePort.listen((data) {
      log("data listen---> $data");
      // ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      //   content: Text('Hello, Snack bar! ${data}'),
      // ));
      setState(() {
        _counter = data;
      });

    });
  }

  // Entry point for the isolate
  static void _isolateEntryPoint(SendPort sendPort) {
    int counter = 0;
    Timer.periodic(const Duration(seconds: 3), (timer) {
      counter++;
      sendPort.send(counter);
      Notify.instanceNotify(counter);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolate Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Counter:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Object Detect Demo
// List<CameraDescription>? cameras;
// void  main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     cameras = await availableCameras();
//   } on CameraException catch (e) {
//     print('Error: $e.code\nError Message: $e.message');
//   }
//   runApp(new MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'tflite real-time detection',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.dark,
//       ),
//       home: HomePage(cameras),
//     );
//   }
// }
