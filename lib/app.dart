import 'package:flutter/material.dart';
import 'package:my_date_picker/my_date_picker/my_date_picker.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Andres Le',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Column(
            spacing: 50,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('My Date Picker', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              MyDatePicker(onSelected: (result) => {}),
            ],
          ),
        ),
      ),
    );
  }
}
