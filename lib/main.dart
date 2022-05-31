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
      title: 'Imbedded',
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
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  late Data data;
  @override
  void initState() {
    () async {
      data = Data.fromJson((await ref.get()).value as Map<String, dynamic>);
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
          'Imbbed System',
          textAlign: TextAlign.center,
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
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
                    Switch(
                      value: data.System,
                      onChanged: (value) {
                        setState(() {
                          data.System = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: 200,
                      child: data.System
                          ? const Text(
                              'On',
                              style: TextStyle(color: Colors.blue),
                            )
                          : const Text(
                              'Off',
                              style: TextStyle(color: Colors.red),
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
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
                    Switch(
                      value: data.OpeningTime,
                      onChanged: (value) {
                        setState(() {
                          data.OpeningTime = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: 200,
                      child: data.OpeningTime
                          ? Row(
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
                                      '${data.TimeRange.start.hour.toString().padLeft(2, '0')}:${data.TimeRange.start.minute.toString().padLeft(2, '0')}'),
                                ),
                                const Text(
                                  '-',
                                  style: TextStyle(color: Colors.blue),
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
                                      '${data.TimeRange.end.hour.toString().padLeft(2, '0')}:${data.TimeRange.end.minute.toString().padLeft(2, '0')}'),
                                ),
                              ],
                            )
                          : const Text(
                              'Always',
                              style: TextStyle(color: Colors.blue),
                            ),
                    ),
                  ],
                ),
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
                    Switch(
                      value: data.MotionSensor,
                      onChanged: (value) {
                        setState(() {
                          data.MotionSensor = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: 200,
                      child: data.MotionSensor
                          ? const Text(
                              'On',
                              style: TextStyle(color: Colors.blue),
                            )
                          : const Text(
                              'Off',
                              style: TextStyle(color: Colors.red),
                            ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 300,
                      child: Text(
                        'Light Threshold',
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Slider(
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
                    SizedBox(
                      width: 300,
                      child: Text('Turn on when < ${data.Light.round()} %'),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  child: isSaving
                      ? const SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isSaving = true;
                            });
                            await data.save();
                            await Future.delayed(const Duration(seconds: 1));
                            setState(() {
                              isSaving = false;
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Save'),
                          ),
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
                Text('Human Count: ${data.Human}'),
              ],
            ),
    );
  }
}
