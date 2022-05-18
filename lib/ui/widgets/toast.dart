import 'package:flutter/material.dart';

class Toast {
  static void show({required context, required String text, required Widget icon, String? extra, Function()? func}) {
    OverlayState overlayState = Overlay.of(context)!;
    OverlayEntry overlayEntry = OverlayEntry(builder: (_) => const SizedBox.shrink());

    const Duration d = Duration(seconds: 1);
    double o = .0;

    overlayEntry = OverlayEntry(builder: (context) =>
      StatefulBuilder(
        builder: (_, setState) {
          WidgetsBinding.instance.addPostFrameCallback((__) {
            if (o == .0) {
              setState(() => o = 1.0);
              Future.delayed(const Duration(seconds: 3) + d).then((_) {
                if (overlayEntry.mounted) setState(() => o = .1);

                Future.delayed(d).then((_) {
                  if (overlayEntry.mounted) overlayEntry.remove();
                });
              });
            }
          });

          return Positioned(
            bottom: 70,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: o,
                    duration: d,
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            color: Colors.black.withOpacity(0.75)
                          ),
                          height: 48.0,
                          //width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 6.6, right: 15.0),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                padding: const EdgeInsets.only(left: 10.0),
                                child: icon
                              ),
                              Text(
                                text,
                                style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.0
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                      onTap: () {
                        if (func != null) {
                          overlayEntry.remove();
                          func();
                        }
                      }
                    ),
                  )
                ],
              ),
            ),
          );
        },
      )
    );

    overlayState.insert(overlayEntry);
  }
}
