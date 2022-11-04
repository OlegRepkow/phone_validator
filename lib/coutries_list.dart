import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:phone_validator/cubit/counter_cubit.dart';
import 'package:phone_validator/model/coutry_model.dart';
import 'package:phone_validator/styles/text_styles.dart';

class CountriesList extends StatefulWidget {
  CountriesList({Key key, this.callbackCode}) : super(key: key);
  Function(String, String) callbackCode;

  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewCounterCubit, CounterState>(
      builder: (context, state) {
        if (state is CountryHasDataState) {
          return Center(
            child: ListView(
                children: state.countryCode.map((item) {
              // return list.add(e);
              return InkWell(
                onTap: () {
                  Navigator.pop(context);
                  widget.callbackCode(item.callingCodes.first, item.flag);
                },
                child: ItemList(
                  countryCode: item,
                ),
              );
            }).toList()),
          );
        } else if (state is CountryHasSeatchDataState) {
          return Center(
            child: ListView(
                children: state.countryCode.map((item) {
              return InkWell(
                onTap: () {
                  Navigator.pop(context);
                  widget.callbackCode(item.callingCodes.first, item.flag);
                },
                child: ItemList(
                  countryCode: item,
                ),
              );
            }).toList()),
          );
        } else if (state is CountryLoadingState) {
          return const Center(
              child: CircularProgressIndicator(
            color: Color.fromRGBO(244, 245, 255, 0.4),
          ));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class ItemList extends StatelessWidget {
  ItemList({
    key,
    this.countryCode,
  }) : super(key: key);

  final Country countryCode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            margin: const EdgeInsets.only(right: 20, left: 20),
            height: 20,
            width: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SvgPicture.network(
                countryCode.flag,
                fit: BoxFit.fill,
                cacheColorFilter: false,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 12),
            width: 40,
            height: 20,
            child: Text(
              '+${countryCode.callingCodes.first}',
              style: Styles.codeCoutryFont,
            ),
          ),
          Expanded(
            child: Text(
              countryCode.name,
              style: Styles.nameCoutryFont,
            ),
          ),
        ],
      ),
    );
  }
}
