import 'package:flutter/material.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/extensions.dart';
import 'package:hockey/main.dart';
import 'package:hockey/ui/provider/prefsprovider.dart';
import 'package:hockey/ui/widgets/platform_button.dart';
import 'package:hockey/ui/widgets/platform_textfield.dart';
import 'package:provider/provider.dart';

import '../../data/utils/localization.dart';

class NewItemDialog extends StatefulWidget {
  final bool? isName;
  final Team? team;
  final Function? changeData;

  const NewItemDialog({
    Key? key,
    this.isName,
    this.team,
    this.changeData
  }) : super(key: key);

  @override
  _NewItemDialogState createState() => _NewItemDialogState();
}

class _NewItemDialogState extends State<NewItemDialog> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    _textController.text = widget.isName! ?
    widget.team!.teamName! : widget.team!.arena!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16)
          ),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        dialogLine,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 40),
                            const Text(
                              "Team",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            getIconButton(
                              child: const Icon(
                                Icons.close,
                                size: 24,
                                color: Colors.grey,
                              ),
                              context: context,
                              onTap: () {
                                Navigator.pop(context);
                              }
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 32),
                            Text(
                              widget.isName! ? "Team name" :
                              "Stadium name",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            const SizedBox(height: 8),
                            PlatformTextField(
                              controller: _textController,
                              showClear: false,
                              isForNotes: true,
                              maxLines: 1,
                              hintText: AppLocalizations.of(context, 'type_hint')
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: PlatformButton(
                                fontSize: 20,
                                onPressed: () async {
                                  final title = _textController.text.trim();
                                  if(title.isNotEmpty){
                                    widget.changeData!(
                                      widget.team!,
                                      title,
                                      widget.isName,
                                    );
                                    Navigator.pop(context);
                                  }
                                  else{
                                    debugPrint("Empty field now");
                                  }
                                },
                                text: "Save changes",
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
