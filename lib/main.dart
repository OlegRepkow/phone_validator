import 'package:flutter/material.dart';

import 'package:phone_validator/country_button.dart';
import 'package:phone_validator/widgets/own_text_field.dart';
import 'package:phone_validator/styles/text_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String phoneNumber;
  bool isSelect = false;

  @override
  void initState() {
    super.initState();
  }

  selected() {
    setState(() {
      isSelect = true;
    });
  }

  unSelected() {
    setState(() {
      isSelect = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(142, 170, 251, 1),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding:
                  EdgeInsets.only(top: 80, left: 20, right: 11, bottom: 161),
              child: SizedBox(
                width: 344,
                child: Text(
                  'Get Started',
                  style: Styles.maineFont,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                CountryButton(),
                Expanded(
                  child: OwnTextField(
                    hasFormater: true,
                    hintTextTextField: 'Your phone number',
                    textFieldType: TextInputType.phone,
                    editingText: (value) {
                      if (value != null) {
                        phoneNumber = value;
                        if (value.length == 14) {
                          selected();
                        } else {
                          
                          unSelected();
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200, left: 350),
              child: InkWell(
                onTap: () {
                  isSelect ? print('$phoneNumber') : null;
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: isSelect
                          ? Colors.white
                          : Color.fromRGBO(244, 245, 255, 0.4),
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  height: 48,
                  width: 48,
                  child: Image.asset(
                    'assets/icons/right.png',
                    color: isSelect
                        ? Color.fromRGBO(87, 77, 113, 1)
                        : Color.fromRGBO(123, 134, 180, 1),
                  ),
                  // color: Color.fromRGBO(244, 245, 255, 0.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
