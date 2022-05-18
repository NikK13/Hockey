import 'package:flutter/material.dart';
import '../../data/utils/app.dart';
import '../../data/utils/appnavigator.dart';

class PlatformAppBar extends StatelessWidget {
  final String? title;
  final double titleFontSize;
  final Widget? trailing;

  const PlatformAppBar({
    Key? key,
    this.title,
    this.titleFontSize = 16,
    this.trailing
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => AppNavigator.of(context).pop(),
          child: Icon(
            App.platform == "ios" ?
            Icons.arrow_back_ios : Icons.arrow_back,
            color: Theme.of(context).brightness == Brightness.light
              ? Colors.black : Colors.white
          )
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Text(
            title!,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w600
            ),
          ),
        ),
        trailing == null ?
        const SizedBox(width: 28) :
        trailing!,
      ],
    );
  }
}
