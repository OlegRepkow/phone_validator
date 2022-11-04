import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_validator/coutries_list.dart';
import 'package:phone_validator/model/coutry_model.dart';
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
  Future<List<Country>> futureCoutry;
  String nameBig;
  String nameFlag;

  @override
  void initState() {
    super.initState();
    futureCoutry = getCountry();
  }

  var newContryList = CountriesList();
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          final bottomSheet = showModalBottomSheet(
            backgroundColor: const Color.fromRGBO(142, 170, 251, 1),
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            context: context,
            builder: (context) => Column(
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
                    if (value != null) {
                      getCountry(value);
                    }
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
                      callbackCode: (name, flag) {
                        setState(() {
                          nameBig = name;
                          nameFlag = flag;
                          print(nameBig);
                        });
                      },
                    )),
              ],
            ),
          );
        },
        child: ButtonView(nameFlag: nameFlag, nameBig: nameBig));
  }
}

class ButtonView extends StatelessWidget {
  const ButtonView({
    Key key,
    @required this.nameFlag,
    @required this.nameBig,
  }) : super(key: key);

  final String nameFlag;
  final String nameBig;

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
                  nameFlag ?? 'https://flagcdn.com/ua.svg',
                  fit: BoxFit.fill,
                  cacheColorFilter: true,
                )),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            nameBig ?? '+380',
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
