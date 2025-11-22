import 'package:flutter/material.dart';
import 'package:my_date_picker/app/date_picker_controller.dart';
import 'package:my_date_picker/app/my_date_picker.dart';
import 'package:provider/provider.dart';

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
              Text(
                'My Date Picker',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ChangeNotifierProvider(
                create: (context) => DatePickerController(),
                child: MyDatePicker(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
