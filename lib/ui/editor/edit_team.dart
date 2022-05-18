import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/app.dart';
import 'package:hockey/data/utils/extensions.dart';
import 'package:hockey/main.dart';
import 'package:hockey/ui/dialog/new_item_dialog.dart';
import 'package:hockey/ui/dialog/team_choose_dialog.dart';
import 'package:hockey/ui/widgets/appbar.dart';
import 'package:hockey/ui/widgets/backgrounded.dart';
import 'package:hockey/ui/widgets/loading.dart';
import 'package:hockey/ui/widgets/platform_button.dart';

class TeamEditPage extends StatefulWidget {
  const TeamEditPage({Key? key}) : super(key: key);

  @override
  State<TeamEditPage> createState() => _TeamEditPageState();
}

class _TeamEditPageState extends State<TeamEditPage> {
  //Team? _selectedTeam;

  final List<Team> _allTeams = [];
  final _imagePicker = ImagePicker();

  File? _imageFile;
  File? _croppingImage;

  int _selectedId = 1;

  Widget? slideWidget;

  @override
  void initState() {
    _imageFile = File("$filesPath/team$_selectedId.png");
    databaseBloc.loadIdTeam(_selectedId);
    databaseBloc.fetchAllTeams().then((value){
      _allTeams.addAll(value);
    });
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
        final newFile = File("$filesPath/team$_selectedId.png");
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
            child: StreamBuilder(
              stream: databaseBloc.teamStream,
              builder: (context, AsyncSnapshot<Team?> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                  children: [
                    const PlatformAppBar(
                      title: "Team",
                      titleFontSize: 22,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      snapshot.data!.teamName!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 0.98,
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: TeamLogo(
                              team: snapshot.data,
                              imageFile: _imageFile!,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: PlatformButton(
                            text: "Stadium name",
                            onPressed: () async{
                              showDialog(snapshot.data!, false);
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: PlatformButton(
                            text: "Team name",
                            onPressed: (){
                              showDialog(snapshot.data!, true);
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: PlatformButton(
                            text: "Team emblem",
                            onPressed: () async{
                              await _pickGalleryImage();
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: PlatformButton(
                            text: "Change team",
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
                                builder: (context) => DraggableScrollableSheet(
                                  initialChildSize: 0.95,
                                  maxChildSize: 0.95,
                                  expand: false,
                                  builder: (context, controller){
                                    /*if(slideWidget == null){
                                      _slideMenu = SlideMenu(
                                        bloc: _historyBloc,
                                        bmBloc: _bookmarksBloc,
                                        controller: _controller,
                                        scrollController: controller,
                                        initialUrl: widget.prefs!.initialURL!,
                                      );
                                    }
                                    return _slideMenu!;*/
                                    return TeamChooseDialog(
                                      teams: _allTeams,
                                      scrollController: controller,
                                      changeTeam: _selectTeam,
                                    );
                                  },
                                ),
                                //backgroundColor: Colors.grey.shade200
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8)
                  ],
                );
                } else {
                  return Center(
                    child: LoadingView(color: HexColor.fromHex(App.appColor)),
                  );
                }
              }
            ),
          ),
        ),
      ),
    );
  }

  void showDialog(Team team, bool isName){
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16)
        )
      ),
      context: context,
      constraints: getDialogConstraints(context),
      isScrollControlled: true,
      isDismissible: false,
      builder: (context) => NewItemDialog(
        isName: isName,
        changeData: changeTeamData,
        team: team,
      )
    );
  }

  void changeTeamData(Team team, String data, bool isName){
    if(isName){
      team.teamName = data;
    }
    else{
      team.arena = data;
    }
    databaseBloc.updateATeam(team);
    databaseBloc.fetchAllTeams().then((value){
      _allTeams..clear()..addAll(value);
    });
  }

  void _selectTeam(int id){
    setState(() {
      _selectedId = id;
      _imageFile = File("$filesPath/team$_selectedId.png");
    });
    databaseBloc.loadIdTeam(_selectedId);
  }
}

class TeamLogo extends StatelessWidget {
  final Team? team;
  final File? imageFile;

  const TeamLogo({
    Key? key,
    required this.team,
    this.imageFile
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageFile!.existsSync() ? Image.file(
      imageFile!,
      fit: BoxFit.cover,
    ) : Image.asset(
      "assets/images/${team!.emblem}.png",
      fit: BoxFit.fill,
    );
  }
}

