import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/common/constants/colors.dart';
import 'package:tanysu/features/choose_city/data/models/city.dart';
import 'package:tanysu/features/choose_city/presentation/bloc/choose_city_bloc.dart';
import 'package:tanysu/l10n/translate.dart';

class CityField extends StatefulWidget {
  const CityField({
    super.key,
    required this.controllerId,
    required this.controller,
    required this.cityId,
  });
  final TextEditingController controller;
  final TextEditingController controllerId;
  final int? cityId;
  @override
  State<CityField> createState() => _CityFieldState();
}

class _CityFieldState extends State<CityField> {
  late ChooseCityBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ChooseCityBloc>(context);

    super.initState();
  }

  CityModel? selectedValue;
  @override
  Widget build(BuildContext context) {
    bloc.add(GetAllCity());
    return BlocConsumer<ChooseCityBloc, ChooseCityState>(
      listener: (context, state) {
        if (state is CityGot) {}
      },
      builder: (context, state) {
        if (state is CityGot) {
          if (widget.cityId != null) {
            for (int i = 0; i < state.cities.length; i++) {
              if (state.cities[i].id == widget.cityId) {
                selectedValue = state.cities[i];
              }
            }
          }
          return DropdownButton<CityModel>(
            value: selectedValue,
            style: GoogleFonts.montserrat(
              color: Colors.black87,
              fontSize: 14,
            ),
            hint: Text(translation(context).select_city),
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
                  widget.controller.text = value.name.toString();
                  widget.controllerId.text = value.id.toString();
                },
              );
            },
          );
        } else if (state is CityGetting) {
          return Platform.isAndroid
              ? CircularProgressIndicator(
                  color: secondColor,
                  strokeWidth: 3,
                )
              : CupertinoActivityIndicator(
                  color: secondColor,
                );
        } else {
          return Text(translation(context).error);
        }
      },
    );
  }
}
