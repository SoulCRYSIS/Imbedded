import 'package:embbed/data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inbedded',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyText2: TextStyle(fontSize: 24),
          button: TextStyle(fontSize: 24),
        ),
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  bool isSaving = false;
  bool isReseting = false;
  late Data data;
  @override
  void initState() {
    () async {
      data = Data.fromJson((await FirebaseDatabase.instance.ref().get()).value
          as Map<String, dynamic>);
      setState(() {
        isLoading = false;
      });
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Inbedded System',
          textAlign: TextAlign.center,
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Tooltip(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 220, 225, 230),
                          ),
                          textStyle: TextStyle(fontSize: 16),
                          triggerMode: TooltipTriggerMode.tap,
                          message:
                              'Use this page for setting conditions to turn the light on or off.\nThere are two mode for LED light.\nThe LED will continue to turn on until the conditions are\nnot met anymore when motion sensor option is turned off.\nThe LED will turn on after the conditions are met and close\nautomatically after a duration when motion sensor option is turn on.',
                          child: Icon(
                            Icons.info_outline_rounded,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 200,
                        child: Text(
                          'System',
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Tooltip(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 220, 225, 230),
                          ),
                          textStyle: TextStyle(fontSize: 16),
                          triggerMode: TooltipTriggerMode.tap,
                          message:
                              'Set to True to turn the light on,\nif the set conditions are met.\nLED always turn off when set to False.',
                          child: Icon(
                            Icons.info_outline_rounded,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 150,
                        child: Switch(
                          value: data.System,
                          onChanged: (value) {
                            setState(() {
                              data.System = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 200,
                        child: Text(
                          'Motion Sensor',
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Tooltip(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 220, 225, 230),
                          ),
                          textStyle: TextStyle(fontSize: 16),
                          triggerMode: TooltipTriggerMode.tap,
                          message:
                              'If disable, device will not counting people even other conditions are met.\nSet True to enable people counting but other conditions\nhave to also be met in order for counter to increase.\nLight will turn on for a duration when a motion is detected before automatically close.',
                          child: Icon(
                            Icons.info_outline_rounded,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 150,
                        child: Switch(
                          value: data.MotionSensor,
                          onChanged: (value) {
                            setState(() {
                              data.MotionSensor = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 200,
                        child: Text(
                          'Opening Time',
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Tooltip(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 220, 225, 230),
                          ),
                          textStyle: TextStyle(fontSize: 16),
                          triggerMode: TooltipTriggerMode.tap,
                          message:
                              'If set, LED will always turn off when current time\nis out off range, even when other conditions are met.',
                          child: Icon(
                            Icons.info_outline_rounded,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 150,
                        child: Switch(
                          value: data.OpeningTime,
                          onChanged: (value) {
                            setState(() {
                              data.OpeningTime = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    child: data.OpeningTime
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  TimeOfDay? newTime = await showTimePicker(
                                    context: context,
                                    initialTime: data.TimeRange.start,
                                    builder: (context, child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child ?? Container(),
                                      );
                                    },
                                  );
                                  if (newTime != null) {
                                    setState(() {
                                      data.TimeRange.start = newTime;
                                    });
                                  }
                                },
                                child: Text(
                                  '${data.TimeRange.start.hour.toString().padLeft(2, '0')}:${data.TimeRange.start.minute.toString().padLeft(2, '0')}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              const Text(
                                '-',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  TimeOfDay? newTime = await showTimePicker(
                                    context: context,
                                    initialTime: data.TimeRange.end,
                                    builder: (context, child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child ?? Container(),
                                      );
                                    },
                                  );
                                  if (newTime != null) {
                                    setState(() {
                                      data.TimeRange.end = newTime;
                                    });
                                  }
                                },
                                child: Text(
                                  '${data.TimeRange.end.hour.toString().padLeft(2, '0')}:${data.TimeRange.end.minute.toString().padLeft(2, '0')}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          )
                        : const Text(
                            'Always',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                            ),
                          ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Light Threshold',
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Tooltip(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 220, 225, 230),
                          ),
                          textStyle: TextStyle(fontSize: 16),
                          triggerMode: TooltipTriggerMode.tap,
                          message:
                              'LED will always turn off when the light intensity\nat the device is above the set value',
                          child: Icon(
                            Icons.info_outline_rounded,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 300,
                    child: Slider(
                      value: data.Light,
                      max: 100,
                      min: 0,
                      divisions: 100,
                      label: data.Light.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          data.Light = value;
                        });
                      },
                    ),
                  ),
                  Text(
                    'Turn on when < ${data.Light.round()} %',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 45,
                    child: isSaving
                        ? Container(
                            padding: const EdgeInsets.all(8),
                            width: 45,
                            height: 45,
                            child: const CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isSaving = true;
                              });
                              data.update = true;
                              await data.save();
                              await Future.delayed(const Duration(seconds: 1));
                              setState(() {
                                isSaving = false;
                              });
                            },
                            child: const Text('Save'),
                          ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(
                    indent: 50,
                    endIndent: 50,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Statistics',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder<DatabaseEvent>(
                        stream: FirebaseDatabase.instance.ref('Human').onValue,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                                'Human Count: ${snapshot.data!.snapshot.value}');
                          }
                          return const Text('Loading...');
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Tooltip(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 220, 225, 230),
                          ),
                          textStyle: TextStyle(fontSize: 16),
                          triggerMode: TooltipTriggerMode.tap,
                          message:
                              'Display how many people walked pass the devices.\nCan press reset count to set to zero.',
                          child: Icon(
                            Icons.info_outline_rounded,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 45,
                    child: isReseting
                        ? Container(
                            padding: const EdgeInsets.all(8),
                            width: 45,
                            height: 45,
                            child: const CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isReseting = true;
                              });
                              await FirebaseDatabase.instance
                                  .ref('Human')
                                  .set(0);
                              await Future.delayed(const Duration(seconds: 1));
                              setState(() {
                                isReseting = false;
                              });
                            },
                            child: const Text('Reset Count'),
                          ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }
}
