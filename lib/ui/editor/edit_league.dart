import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hockey/data/model/league.dart';
import 'package:hockey/data/utils/app.dart';
import 'package:hockey/data/utils/extensions.dart';
import 'package:hockey/main.dart';
import 'package:hockey/ui/dialog/league_choose_dialog.dart';
import 'package:hockey/ui/widgets/appbar.dart';
import 'package:hockey/ui/widgets/backgrounded.dart';
import 'package:hockey/ui/widgets/platform_button.dart';

class LeagueEditPage extends StatefulWidget {
  const LeagueEditPage({Key? key}) : super(key: key);

  @override
  State<LeagueEditPage> createState() => _LeagueEditPageState();
}

class _LeagueEditPageState extends State<LeagueEditPage> {
  League? _selectedLeague;

  final _imagePicker = ImagePicker();

  File? _imageFile;
  File? _croppingImage;

  @override
  void initState() {
    _selectedLeague = League.leagues.first;
    _imageFile = File("$filesPath/${_selectedLeague!.leagueName}.png");
    super.initState();
  }

  _pickGalleryImage() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      setState(() => _croppingImage = File(pickedFile.path));
      await _cropImage();
    }
    else{
      debugPrint('No image selected.');
    }
  }

  Future _cropImage() async {
    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: _croppingImage!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      compressFormat: ImageCompressFormat.png,
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: HexColor.fromHex(App.appColor),
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true,
      ),
      iosUiSettings: const IOSUiSettings(
        title: 'Cropper',
      ),
      compressQuality: 80,
    );
    if (croppedFile != null) {
      _imageFile = croppedFile;
      final data = await _imageFile!.readAsBytes();
      setState(() {
        final newFile = File("$filesPath/${_selectedLeague!.leagueName}.png");
        newFile.writeAsBytes(data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: Padding(
            padding: App.appPadding,
            child: Column(
              children: [
                PlatformAppBar(
                  title: _selectedLeague!.leagueName,
                  titleFontSize: 28,
                ),
                Expanded(
                  child: Center(
                    child: LeagueLogo(
                      league: _selectedLeague,
                      isExists: _imageFile!.existsSync(),
                      imageFile: _imageFile,
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: PlatformButton(
                        text: "Change emblem",
                        onPressed: () async{
                          await _pickGalleryImage();
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: PlatformButton(
                        text: "Change league",
                        onPressed: (){
                          showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              )
                            ),
                            context: context,
                            builder: (context) => LeagueChooseDialog(
                              changeLeague: changeLeague,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeLeague(int id){
    setState(() {
      _selectedLeague = League.leagues[id];
      _imageFile = File("$filesPath/${_selectedLeague!.leagueName}.png");
    });
  }
}

class LeagueLogo extends StatelessWidget {
  final League? league;
  final File? imageFile;
  final bool? isExists;

  const LeagueLogo({
    Key? key,
    required this.league,
    required this.isExists,
    this.imageFile
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isExists! ? SizedBox(
      width: 250,
      height: 250,
      child: Image.file(
        imageFile!,
        fit: BoxFit.cover,
      ),
    ) : SizedBox(
      width: 230,
      height: 250,
      child: Image.asset(
        "assets/images/${league!.defDrawable}.png",
        fit: BoxFit.fill,
      ),
    );
  }
}

