import 'package:flutter/material.dart';

const double ICON_OFF = -3;
const double ICON_ON = 0;
const double TEXT_OFF = 3;
const double TEXT_ON = 1;
const double ALPHA_OFF = 0;
const double ALPHA_ON = 1;
const int ANIM_DURATION = 300;

class TabItem extends StatelessWidget {
  const TabItem(
      {super.key,
      required this.uniqueKey,
      required this.selected,
      required this.icon,
      required this.title,
      required this.callbackFunction,
      required this.textColor,
      required this.iconColor});

  final UniqueKey uniqueKey;
  final String title;
  final Widget icon;
  final bool selected;
  final Function(UniqueKey uniqueKey) callbackFunction;
  final Color textColor;
  final Color iconColor;

  final double iconYAlign = ICON_ON;
  final double textYAlign = TEXT_OFF;
  final double iconAlpha = ALPHA_ON;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
                duration: const Duration(milliseconds: ANIM_DURATION),
                alignment: Alignment(0, (selected) ? TEXT_ON : TEXT_OFF),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: ANIM_DURATION),
                    style: selected
                        ? TextStyle(
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          )
                        : const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.transparent,
                          ),
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
              duration: const Duration(milliseconds: ANIM_DURATION),
              curve: Curves.easeIn,
              alignment: Alignment(0, (selected) ? ICON_OFF : ICON_ON),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: ANIM_DURATION),
                opacity: (selected) ? ALPHA_OFF : ALPHA_ON,
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  padding: const EdgeInsets.all(0),
                  alignment: const Alignment(0, 0),
                  icon: icon,
                  onPressed: () {
                    callbackFunction(uniqueKey);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
