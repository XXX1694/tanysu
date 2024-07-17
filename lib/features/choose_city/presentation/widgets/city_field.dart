import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/choose_city/data/models/city.dart';
import 'package:tanysu/features/choose_city/presentation/bloc/choose_city_bloc.dart';
import 'package:tanysu/l10n/translate.dart';

class CityField extends StatefulWidget {
  const CityField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  @override
  State<CityField> createState() => _CityFieldState();
}

class _CityFieldState extends State<CityField> {
  late ChooseCityBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ChooseCityBloc>(context);
    bloc.add(GetAllCity());
    super.initState();
  }

  CityModel? selectedValue;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChooseCityBloc, ChooseCityState>(
      listener: (context, state) {
        if (state is CityGot) {
          debugPrint(widget.controller.text);
          if (widget.controller.text.isNotEmpty) {
            for (int i = 0; i < state.cities.length; i++) {
              if (state.cities[i].id == int.parse(widget.controller.text)) {
                selectedValue = state.cities[i];
              }
            }
          }
        }
      },
      builder: (context, state) {
        if (state is CityGot) {
          return DropdownButton<CityModel>(
            value: selectedValue,
            hint: Text(
              translation(context).select_city,
              style: GoogleFonts.montserrat(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            isExpanded: true,
            items: state.cities.map(
              (value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value.name),
                );
              },
            ).toList(),
            borderRadius: BorderRadius.circular(8),
            elevation: 1,
            underline: Container(
              height: 1,
              color: Colors.black38,
            ),
            onChanged: (value) {
              setState(
                () {
                  selectedValue = value!;
                  widget.controller.text = value.id.toString();
                },
              );
            },
          );
        } else if (state is CityGetting) {
          return Platform.isAndroid
              ? const CircularProgressIndicator(
                  color: mainColor,
                  strokeWidth: 3,
                )
              : const CupertinoActivityIndicator(
                  color: mainColor,
                );
        } else {
          return Text(translation(context).error);
        }
      },
    );
  }
}
