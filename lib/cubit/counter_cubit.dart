import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:phone_validator/model/coutry_model.dart';

part 'counter_state.dart';

class NewCounterCubit extends Cubit<CounterState> {
  NewCounterCubit() : super(CounterInitial());
  List<Country> list = <Country>[];

  Future<List<Country>> getCountry([String value]) async {
    emit(CountryLoadingState());
    if (value == null) {
      final response = await http.get('https://restcountries.com/v2/all');
      list = List<Country>.from(
          json.decode(response.body).map((v) => Country.fromJson(v)));
      emit(CountryHasDataState(list));
    } else {
      throw Exception('failed to load');
    }
  }

  Future<List<Country>> searchCountry([String value]) async {
    emit(CountryLoadingState());
    if (value != null) {
      List<Country> newList = [];
      newList.addAll(list.where(
        (element) => element.name.toLowerCase().contains(
              value.toLowerCase(),
            ),
      ));
      newList.addAll(list.where(
        (element) => element.callingCodes.first.toLowerCase().contains(
              value.toLowerCase(),
            ),
      ));
      emit(CountryHasSeatchDataState(newList));
    } else {
      throw Exception('failed to load');
    }
  }
}
