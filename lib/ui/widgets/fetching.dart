import 'package:flutter/material.dart';
import 'package:hockey/data/utils/app.dart';
import 'package:hockey/data/utils/extensions.dart';
import 'package:hockey/data/utils/localization.dart';

class FetchingView extends StatelessWidget {
  final double? progress;

  const FetchingView({Key? key, this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          value: progress,
          valueColor: AlwaysStoppedAnimation(HexColor.fromHex(App.appColor)),
        ),
        const SizedBox(height: 6),
        Text(
          AppLocalizations.of(context, 'loaded').replaceAll("_", (progress! * 100).toStringAsFixed(2)),
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }
}
