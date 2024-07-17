import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/core/widgets/main_button.dart';
import 'package:tanysu/features/choose_city/presentation/widgets/city_field.dart';
import 'package:tanysu/features/search/presentation/bloc/search_bloc.dart';
import 'package:tanysu/features/search/presentation/widgets/gender_field.dart';
import 'package:tanysu/features/search/presentation/widgets/slider.dart';
import 'package:tanysu/l10n/translate.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({
    super.key,
    required this.callback,
    required this.cityController,
    required this.genderController,
    required this.maxAgeController,
    required this.minAgeController,
  });
  final Function({
    required int? cityId,
    required int? maxAge,
    required int? minAge,
    required String? gender,
  }) callback;
  final TextEditingController cityController;
  final TextEditingController genderController;
  final TextEditingController minAgeController;
  final TextEditingController maxAgeController;
  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late SearchBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<SearchBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          translation(context).filter,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black,
              ),
        ),
        centerTitle: true,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.black12,
            width: double.infinity,
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                translation(context).city,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              CityField(
                controller: widget.cityController,
              ),
              const SizedBox(height: 24),
              Text(
                translation(context).try_to_find,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              GenderField(
                controller: widget.genderController,
              ),
              const SizedBox(height: 24),
              Text(
                translation(context).age,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              AgeSlider(
                maxAgeController: widget.maxAgeController,
                minAgeController: widget.minAgeController,
              ),
              const Spacer(),
              MainButton(
                text: translation(context).search,
                onPressed: () {
                  widget.callback(
                    cityId: widget.cityController.text.isEmpty
                        ? null
                        : int.parse(widget.cityController.text),
                    gender: widget.genderController.text.isEmpty
                        ? null
                        : widget.genderController.text,
                    maxAge: widget.maxAgeController.text.isEmpty
                        ? null
                        : int.parse(widget.maxAgeController.text),
                    minAge: widget.minAgeController.text.isEmpty
                        ? null
                        : int.parse(widget.minAgeController.text),
                  );
                  Navigator.pop(context);
                },
                status: 'active',
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
