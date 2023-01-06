// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Use temp variable to only update color when press dialog 'submit' button
  ColorSwatch? _tempMainColor;
  Color? _tempShadeColor;
  ColorSwatch? _mainColor = Colors.blue;
  Color? _shadeColor = Colors.blue[800];

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('CANCEL',style: TextStyle(color: Colors.green,fontSize: 15,),),
            ),
            TextButton(
              child: const Text('SUBMIT',style: TextStyle(color: Colors.green,fontSize: 15,),),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => _mainColor = _tempMainColor);
                setState(() => _shadeColor = _tempShadeColor);
              },
            ),
          ],
        );
      },
    );
  }

  void _openColorPicker() async {
    _openDialog(
      "Color picker",
      MaterialColorPicker(
        selectedColor: _shadeColor,
        onColorChange: (color) => setState(() => _tempShadeColor = color),
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
        onBack: () => print("Back button pressed"),
      ),
    );
  }

  void _openMainColorPicker() async {
    _openDialog(
      "Main Color picker",
      MaterialColorPicker(
        selectedColor: _mainColor,
        allowShades: false,
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
      ),
    );
  }

  void _openAccentColorPicker() async {
    _openDialog(
      "Accent Color picker",
      MaterialColorPicker(
        colors: accentColors,
        selectedColor: _mainColor,
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
        circleSize: 40.0,
        spacing: 10,
      ),
    );
  }

  void _openFullMaterialColorPicker() async {
    _openDialog(
      "Full Material Color picker",
      MaterialColorPicker(
        colors: fullMaterialColors,
        selectedColor: _mainColor,
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text("Material color picker",style: TextStyle(color: Colors.white,fontSize: 15,),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Material color picker",
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 62.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: _mainColor,
                radius: 45.0,
                child: const Text("MAIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              CircleAvatar(
                backgroundColor: _shadeColor,
                radius: 45.0,
                child: const Text("SHADE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32.0),
          InkWell(
            onTap: _openColorPicker,
            child: smallbutton(context, 35, Colors.green, MediaQuery.of(context).size.width/1.7, "Show color picker", Colors.white, 15),
          ),
          const SizedBox(height: 16.0),
          InkWell(
            onTap: _openMainColorPicker,
            child: smallbutton(context, 35, Colors.green, MediaQuery.of(context).size.width/1.7, "Show main color picker", Colors.white, 15),
          ),
          const SizedBox(height: 10.0),
          const Text('(only main color)'),
          const SizedBox(height: 16.0),
          InkWell(
            onTap: _openAccentColorPicker,
            child: smallbutton(context, 35, Colors.green, MediaQuery.of(context).size.width/1.7, "Show accent color picker", Colors.white, 15),
          ),
          const SizedBox(height: 16.0),
          InkWell(
            onTap: _openFullMaterialColorPicker,
            child: smallbutton(context, 35, Colors.green, MediaQuery.of(context).size.width/1.7, "Show full material color picker", Colors.white, 15),
          ),
        ],
      ),
    );
  }
}

Widget smallbutton(BuildContext context,double height, Color buttcolor,double width,String title,Color color,double size){
  return Container(
    height: height,
    width: width,
    alignment: Alignment.center,
      decoration: BoxDecoration(
      color: buttcolor,
      borderRadius: BorderRadius.circular(50)
    ),
    child: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: size,
      ),
    ),
  );
}