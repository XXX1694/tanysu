import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/l10n/translate.dart';

class PartnerList extends StatefulWidget {
  const PartnerList({super.key, required this.controller});
  final TextEditingController controller;
  @override
  State<PartnerList> createState() => _PartnerListState();
}

int selected = 4;

class _PartnerListState extends State<PartnerList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: selected == 0
                  ? const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        mainColor,
                        secondColor,
                      ],
                    )
                  : null,
              border: selected != 0
                  ? Border.all(
                      color: Colors.black54,
                      width: 2,
                    )
                  : null,
            ),
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: selected == 0
                    ? GradientText(
                        translation(context).woman,
                        gradient: const LinearGradient(
                          colors: <Color>[
                            mainColor,
                            secondColor,
                          ],
                        ),
                      )
                    : Text(
                        translation(context).woman,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
              ),
            ),
          ),
          onPressed: () {
            setState(() {
              if (selected != 0) {
                selected = 0;
                widget.controller.text = 'female';
              } else {
                selected = 4;
                widget.controller.text = '';
              }
            });
          },
        ),
        const SizedBox(height: 20),
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: selected == 1
                  ? const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        mainColor,
                        secondColor,
                      ],
                    )
                  : null,
              border: selected != 1
                  ? Border.all(
                      color: Colors.black54,
                      width: 2,
                    )
                  : null,
            ),
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: selected == 1
                    ? GradientText(
                        translation(context).man,
                        gradient: const LinearGradient(
                          colors: <Color>[
                            mainColor,
                            secondColor,
                          ],
                        ),
                      )
                    : Text(
                        translation(context).man,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
              ),
            ),
          ),
          onPressed: () {
            setState(() {
              if (selected != 1) {
                selected = 1;
                widget.controller.text = 'male';
              } else {
                selected = 4;
                widget.controller.text = '';
              }
            });
          },
        ),
        const SizedBox(height: 20),
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: selected == 2
                  ? const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        mainColor,
                        secondColor,
                      ],
                    )
                  : null,
              border: selected != 2
                  ? Border.all(
                      color: Colors.black54,
                      width: 2,
                    )
                  : null,
            ),
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: selected == 2
                    ? GradientText(
                        translation(context).everyone,
                        gradient: const LinearGradient(
                          colors: <Color>[
                            mainColor,
                            secondColor,
                          ],
                        ),
                      )
                    : Text(
                        translation(context).everyone,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
              ),
            ),
          ),
          onPressed: () {
            setState(() {
              if (selected != 2) {
                selected = 2;
                widget.controller.text = 'null';
              } else {
                selected = 4;
                widget.controller.text = '';
              }
            });
          },
        ),
      ],
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;

  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
