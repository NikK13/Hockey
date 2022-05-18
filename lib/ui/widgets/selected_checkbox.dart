import 'package:flutter/material.dart';
import 'package:hockey/data/utils/app.dart';
import 'package:hockey/data/utils/extensions.dart';
import 'package:hockey/ui/widgets/ripple.dart';

class SelectedCheckBox extends StatelessWidget {
  final bool? isSelected;
  final Function()? onTap;
  final double size;

  const SelectedCheckBox({
    Key? key,
    this.isSelected,
    this.onTap,
    this.size = 32
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ripple(
      radius: 30,
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        child: isSelected! ? Icon(
          Icons.check,
          color: Colors.white,
          size: size / 2,
        ) : const SizedBox(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isSelected! ?
          HexColor.fromHex(App.appColor) :
          Colors.grey.shade300
        ),
      ),
    );
  }
}
