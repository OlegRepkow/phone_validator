import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_validator/coutries_list.dart';
import 'package:phone_validator/cubit/counter_cubit.dart';

import 'package:phone_validator/widgets/own_text_field.dart';
import 'package:phone_validator/styles/text_styles.dart';

class CountryButton extends StatefulWidget {
  const CountryButton({
    key,
  });

  @override
  State<CountryButton> createState() => _CountryButtonState();
}

class _CountryButtonState extends State<CountryButton> {
  String code;
  String flag;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showModalBottomSheet(
            backgroundColor: const Color.fromRGBO(142, 170, 251, 1),
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            context: context,
            builder: (context) => BlocProvider<NewCounterCubit>(
              create: (context) => NewCounterCubit()..getCountry(),
              child: BlocBuilder<NewCounterCubit, CounterState>(
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: SizedBox(
                              height: 40,
                              width: 295,
                              child: Text(
                                'Coutry code',
                                style: Styles.maineFont,
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: 50,
                          // ),
                          IconClose()
                        ],
                      ),
                      OwnTextField(
                        editingText: (value) {
                          context.read<NewCounterCubit>().searchCountry(value);
                        },
                        hintTextTextField: 'Search',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color.fromRGBO(87, 77, 113, 1),
                        ),
                        textFieldType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: CountriesList(
                          callbackCode: (nameCode, nameFlag) {
                            setState(() {
                              code = '+$nameCode';
                              flag = nameFlag;
                            });
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
        child: ButtonView(flag: flag, code: code));
  }
}

class ButtonView extends StatelessWidget {
  const ButtonView({
    Key key,
    @required this.flag,
    @required this.code,
  }) : super(key: key);

  final String flag;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromRGBO(244, 245, 255, 0.4),
          borderRadius: BorderRadius.all(Radius.circular(16))),
      height: 48,
      width: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.network(
                  flag ?? 'https://flagcdn.com/ua.svg',
                  fit: BoxFit.fill,
                  cacheColorFilter: true,
                )),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            code ?? '+380',
            style: Styles.codeCoutryFont,
          ),
        ],
      ),
    );
  }
}

class IconClose extends StatelessWidget {
  const IconClose({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(244, 245, 255, 0.4),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            height: 20,
            width: 20,
            child: const Icon(
              Icons.close,
              size: 16,
            ),
          ),
        ));
  }
}
