import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:phone_validator/model/coutry_model.dart';
import 'package:phone_validator/styles/text_styles.dart';

List<Country> list = <Country>[];

Future<List<Country>> getCountry([String value]) async {
  if (value == null) {
    final response = await http.get('https://restcountries.com/v2/all');
    list = List<Country>.from(
        json.decode(response.body).map((v) => Country.fromJson(v)));

    return list;
  }

  if (value != null) {
    // print(list.where(
    //   (element) => element.name.toLowerCase().contains(
    //         value.toLowerCase(),
    //       ),
    // ));
    List<Country> newList = [];

    newList.addAll(list.where(
      (element) => element.name.toLowerCase().contains(
            value.toLowerCase(),
          ),
    ));
    print(newList.first.name);
    print(newList);

    return newList;
  } else {
    throw Exception('failed to load');
  }
  // print(list);
}

// var newList = (coutries.map((e) => e.name));

// if (response.statusCode == 200 && value == null) {
//   return List<Country>.from(
//       json.decode(response.body).map((v) => Country.fromJson(v)));
// } else if (value != null) {
//   print(
//     newList
//         .where((v) => (v.toLowerCase().contains(value.toLowerCase())))
//         .toList(),
// );

class CountriesList extends StatefulWidget {
  final Function(String, String) callbackCode;

  CountriesList({
    Key key,
    this.callbackCode,
  }) : super(key: key);

  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  Future<List<Country>> futureCoutry;

  @override
  void initState() {
    super.initState();
    futureCoutry = getCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Country>>(
        future: futureCoutry,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: List.generate(snapshot.data.length, (index) {
                String coutryFlag = snapshot.data[index].flag;
                String coutryCode =
                    '+${snapshot.data[index].callingCodes.first} ';

                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    widget.callbackCode(coutryCode, coutryFlag);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          margin: EdgeInsets.only(right: 20, left: 20),
                          height: 25,
                          width: 25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: SvgPicture.network(
                              coutryFlag,
                              fit: BoxFit.fill,
                              cacheColorFilter: false,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 12),
                          width: 32,
                          height: 20,
                          child: Text(
                            coutryCode,
                            style: Styles.codeCoutryFont,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            snapshot.data[index].name,
                            style: Styles.nameCoutryFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
