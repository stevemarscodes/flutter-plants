import 'package:chat/bloc/plant_bloc.dart';
import 'package:chat/bloc/provider.dart';
import 'package:chat/bloc/room_bloc.dart';

import 'package:chat/helpers/mostrar_alerta.dart';

import 'package:chat/models/plant.dart';
import 'package:chat/models/room.dart';
import 'package:chat/pages/profile_page.dart';

import 'package:chat/services/auth_service.dart';
import 'package:chat/services/plant_services.dart';

import 'package:chat/theme/theme.dart';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class AddUpdatePlantPage extends StatefulWidget {
  AddUpdatePlantPage({this.plant, this.plants, this.isEdit = false, this.room});

  final Plant plant;
  final bool isEdit;
  final Room room;

  final List<Plant> plants;

  @override
  AddUpdatePlantPageState createState() => AddUpdatePlantPageState();
}

class AddUpdatePlantPageState extends State<AddUpdatePlantPage> {
  final nameCtrl = TextEditingController();

  final descriptionCtrl = TextEditingController();

  final genoTypeCtrl = TextEditingController();

  final quantityCtrl = TextEditingController();

  final potCtrl = TextEditingController();

  var tchCtrl = new MaskedTextController(mask: '00');
  var cbdCtrl = new MaskedTextController(mask: '00');

  bool isNameChange = false;
  bool isAboutChange = false;
  bool isGenoTypeChange = false;
  bool isQuantityChange = false;

  bool isGerminatedChange = false;
  bool isFlorationChange = false;

  bool isThcChange = false;

  bool isCbdChange = false;
  bool isPotChange = false;

  bool loading = false;

  String dropdownValue = 'Sexo';

  String setDateG;

  DateTime selectedDateG = DateTime.now();

  TextEditingController _dateGController = TextEditingController();

  Future<Null> _selectDateGermina(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateG,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDateG = picked;
        _dateGController.text = DateFormat('dd/MM/yyyy').format(selectedDateG);
      });
  }

  String setDateF;

  DateTime selectedDateF = DateTime.now();

  TextEditingController _dateFController = TextEditingController();

  Future<Null> _selectDateFlora(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateF,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDateF = picked;
        _dateFController.text = DateFormat('dd/MM/yyyy').format(selectedDateF);
      });
  }

  String optionItemSelected;

  List<DropdownMenuItem> categories = [
    DropdownMenuItem(
      child: Text('Option 1'),
      value: "1",
    ),
    DropdownMenuItem(
      child: Text('option 2 '),
      value: "2",
    )
  ];

  bool isDefault;

  @override
  void initState() {
    nameCtrl.text = widget.plant.name;
    descriptionCtrl.text = widget.plant.description;
    genoTypeCtrl.text = widget.plant.genotype;
    quantityCtrl.text = widget.plant.quantity;

    optionItemSelected = (widget.isEdit) ? widget.plant.sexo : null;
    _dateGController.text = widget.plant.germinated;
    _dateFController.text = widget.plant.flowering;

    tchCtrl.text = widget.plant.thc;

    cbdCtrl.text = widget.plant.cbd;
    potCtrl.text = widget.plant.pot;

    nameCtrl.addListener(() {
      // print('${nameCtrl.text}');
      setState(() {
        if (widget.plant.name != nameCtrl.text)
          this.isNameChange = true;
        else
          this.isNameChange = false;
      });
    });
    descriptionCtrl.addListener(() {
      setState(() {
        if (widget.plant.description != descriptionCtrl.text)
          this.isAboutChange = true;
        else
          this.isAboutChange = false;
      });
    });

    genoTypeCtrl.addListener(() {
      setState(() {
        if (widget.plant.genotype != genoTypeCtrl.text)
          this.isGenoTypeChange = true;
        else
          this.isGenoTypeChange = false;
      });
    });

    quantityCtrl.addListener(() {
      setState(() {
        if (widget.plant.quantity != quantityCtrl.text)
          this.isQuantityChange = true;
        else
          this.isQuantityChange = false;
      });
    });

    tchCtrl.addListener(() {
      setState(() {
        if (widget.plant.thc != tchCtrl.text)
          this.isThcChange = true;
        else
          this.isThcChange = false;
      });
    });

    cbdCtrl.addListener(() {
      setState(() {
        if (widget.plant.cbd != cbdCtrl.text)
          this.isCbdChange = true;
        else
          this.isCbdChange = false;
      });
    });

    _dateGController.addListener(() {
      setState(() {
        if (widget.plant.germinated != _dateGController.text)
          this.isGerminatedChange = true;
        else
          this.isGerminatedChange = false;
      });
    });

    _dateFController.addListener(() {
      setState(() {
        if (widget.plant.flowering != _dateFController.text)
          this.isFlorationChange = true;
        else
          this.isFlorationChange = false;
      });
    });

    potCtrl.addListener(() {
      setState(() {
        if (widget.plant.pot != potCtrl.text)
          this.isPotChange = true;
        else
          this.isPotChange = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    nameCtrl.dispose();

    descriptionCtrl.dispose();

    genoTypeCtrl.dispose();

    quantityCtrl.dispose();

    plantBloc?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

    final bloc = CustomProvider.plantBlocIn(context);

    //final size = MediaQuery.of(context).size;

    final isSexoChange =
        (widget.plant.sexo != optionItemSelected && optionItemSelected != null)
            ? true
            : false;

    final isControllerChange = isNameChange &&
        isQuantityChange &&
        isGerminatedChange &&
        isFlorationChange;

    final isControllerChangeEdit =
        isNameChange || isAboutChange || isGenoTypeChange || isQuantityChange;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          (widget.isEdit)
              ? _createButton(bloc, isControllerChangeEdit)
              : _createButton(bloc, isControllerChange),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: currentTheme.accentColor,
          ),
          iconSize: 30,
          onPressed: () =>
              //  Navigator.pushReplacement(context, createRouteProfile()),
              Navigator.pop(context),
          color: Colors.white,
        ),
        title: (widget.isEdit) ? Text('Edit plant') : Text('New plant'),
      ),
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (_) {
          //  _snapAppbar();
          // if (_scrollController.offset >= 250) {}
          return false;
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              // controller: _scrollController,
              slivers: <Widget>[
                SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _createName(bloc),
                          SizedBox(
                            height: 10,
                          ),
                          _createGenoType(bloc),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                              },
                              child: _createSexo(bloc)),
                          SizedBox(
                            height: 10,
                          ),
                          _createQuantity(bloc),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode()),
                                _selectDateGermina(context),
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: _dateGController,
                                  keyboardType: TextInputType.datetime,
                                  onSaved: (String val) {
                                    setState(() {
                                      setDateG = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Germination *',
                                    suffixIcon: Icon(
                                      Icons.insert_invitation,
                                      color: Colors.white54,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode()),
                                _selectDateFlora(context),
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: _dateFController,
                                  keyboardType: TextInputType.datetime,
                                  onSaved: (String val) {
                                    setState(() {
                                      setDateF = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Floration *',
                                    suffixIcon: Icon(
                                      Icons.insert_invitation,
                                      color: Colors.white54,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(child: _createThc(bloc)),
                              SizedBox(
                                width: 50,
                              ),
                              Expanded(child: _createCbd(bloc)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _createPot(bloc),
                          SizedBox(
                            height: 10,
                          ),
                          _createDescription(bloc),
                          SizedBox(
                            height: 10,
                          ),

                          /*   _createDescription(bloc), */
                        ],
                      ),
                    )),
              ]),
        ),
      ),
    );
  }

  Widget _createName(PlantBloc bloc) {
    return StreamBuilder(
      stream: bloc.nameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextField(
            controller: nameCtrl,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(30),
            ],
            //  keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                // icon: Icon(Icons.perm_identity),
                //  fillColor: currentTheme.accentColor,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xff20FFD7), width: 2.0),
                ),
                hintText: '',
                labelText: 'Name *',
                //counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeName,
          ),
        );
      },
    );
  }

  Widget _createDescription(PlantBloc bloc) {
    //final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return StreamBuilder(
      stream: bloc.descriptionStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextField(
            inputFormatters: [
              new LengthLimitingTextInputFormatter(100),
            ],
            controller: descriptionCtrl,
            //  keyboardType: TextInputType.emailAddress,

            maxLines: 2,
            //  keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                // icon: Icon(Icons.perm_identity),
                //  fillColor: currentTheme.accentColor,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xff20FFD7), width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                hintText: '',
                labelText: 'Description',
                //counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeDescription,
          ),
        );
      },
    );
  }

  Widget _createGenoType(PlantBloc bloc) {
    return StreamBuilder(
      stream: bloc.genoTypeStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextField(
            controller: genoTypeCtrl,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(30),
            ],
            //  keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                // icon: Icon(Icons.perm_identity),
                //  fillColor: currentTheme.accentColor,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xff20FFD7), width: 2.0),
                ),
                hintText: '',
                labelText: 'Genotype',
                //counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeGenoType,
          ),
        );
      },
    );
  }

  Widget _createSexo(PlantBloc bloc) {
    final size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: bloc.sexoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(

            //leading: FaIcon(FontAwesomeIcons.moon, color: accentColor),
            height: 50,
            width: size.width,
            child: DropdownButtonFormField(
              hint: Text('Sexo'),
              value: optionItemSelected,
              items: categories,
              onChanged: (optionItem) {
                setState(() {
                  optionItemSelected = optionItem;
                });
              },
            ));
        /* SelectDropList(
              optionItemSelected,
              dropListModel,
              (optionItem) {
                setState(() {
                  optionItemSelected = optionItem;
                  sexoModel.sexo = optionItemSelected;
                });
              },
            )); */
      },
    );
  }

  Widget _createQuantity(PlantBloc bloc) {
    return StreamBuilder(
      stream: bloc.quantityStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextField(
            controller: quantityCtrl,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(4),
            ],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                // icon: Icon(Icons.perm_identity),
                //  fillColor: currentTheme.accentColor,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xff20FFD7), width: 2.0),
                ),
                hintText: '',
                labelText: 'Quantity *',
                //counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeQuantity,
          ),
        );
      },
    );
  }

  Widget _createThc(PlantBloc bloc) {
    return StreamBuilder(
      stream: bloc.tchStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextField(
            controller: tchCtrl,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(3),
            ],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                suffixIcon: Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      '%',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white54),
                    )),
                //  fillColor: currentTheme.accentColor,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xff20FFD7), width: 2.0),
                ),
                hintText: '',
                labelText: 'THC',
                //counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeThc,
          ),
        );
      },
    );
  }

  Widget _createCbd(PlantBloc bloc) {
    return StreamBuilder(
      stream: bloc.tchStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextField(
            controller: cbdCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                suffixIcon: Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      '%',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white54),
                    )),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xff20FFD7), width: 2.0),
                ),
                hintText: '',
                labelText: 'CBD',
                //counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeCbd,
          ),
        );
      },
    );
  }

  Widget _createPot(PlantBloc bloc) {
    return StreamBuilder(
      stream: bloc.potStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextField(
            controller: potCtrl,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(5),
            ],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                // icon: Icon(Icons.perm_identity),
                //  fillColor: currentTheme.accentColor,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xff20FFD7), width: 2.0),
                ),
                hintText: '',
                labelText: 'Lt flower pot *',
                //counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changePot,
          ),
        );
      },
    );
  }

  Widget _createButton(
    PlantBloc bloc,
    bool isControllerChange,
  ) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

        final isInvalid = snapshot.hasError;
        return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Next',
                  style: TextStyle(
                      color: isControllerChange && !isInvalid
                          ? currentTheme.accentColor
                          : Colors.white.withOpacity(0.30),
                      fontSize: 18),
                ),
              ),
            ),
            onTap: isControllerChange && !isInvalid && !loading
                ? () => {
                      setState(() {
                        loading = true;
                      }),
                      FocusScope.of(context).unfocus(),
                      (widget.isEdit) ? _editPlant(bloc) : _createRoom(bloc),
                    }
                : null);
      },
    );
  }

  _createRoom(PlantBloc bloc) async {
    final plantService = Provider.of<PlantService>(context, listen: false);

    final authService = Provider.of<AuthService>(context, listen: false);
    final room = widget.room.id;

    final uid = authService.profile.user.uid;

    final name = (bloc.name == null) ? widget.plant.name : bloc.name.trim();
    final description = (descriptionCtrl.text == "")
        ? widget.plant.description
        : bloc.description.trim();

    final genoType =
        (bloc.genoType == null) ? widget.plant.genotype : bloc.genoType.trim();

    final sexo = optionItemSelected;

    final quantity =
        (bloc.quantity == null) ? widget.plant.quantity : bloc.quantity.trim();

    final germinated = _dateGController.text;

    final flowering = _dateFController.text;

    final thc = (bloc.thc == null) ? widget.plant.thc : bloc.thc.trim();

    final cbd = (bloc.cbd == null) ? widget.plant.cbd : bloc.cbd.trim();

    final pot = (bloc.pot == null) ? widget.plant.pot : bloc.pot.trim();

    final newPlant = Plant(
        name: name,
        description: description,
        genotype: genoType,
        sexo: sexo,
        quantity: quantity,
        germinated: germinated,
        flowering: flowering,
        thc: thc,
        cbd: cbd,
        pot: pot,
        room: room,
        user: uid);

    final createPlantResp = await plantService.createPlant(newPlant);

    if (createPlantResp != null) {
      if (createPlantResp.ok) {
        // widget.plants.add(createPlantResp.plant);
        loading = false;

        // plantBloc.getPlants(widget.plant.id);
        roomBloc.getRooms(uid);
        Navigator.pop(context);
        setState(() {});
      } else {
        mostrarAlerta(context, 'Error', createPlantResp.msg);
      }
    } else {
      mostrarAlerta(
          context, 'Error del servidor', 'lo sentimos, Intentelo mas tarde');
    }
    //Navigator.pushReplacementNamed(context, '');
  }

  _editPlant(PlantBloc bloc) async {
    final plantService = Provider.of<PlantService>(context, listen: false);

    final name = (bloc.name == null) ? widget.plant.name : bloc.name.trim();
    final description = (descriptionCtrl.text == "")
        ? widget.plant.description
        : descriptionCtrl.text.trim();

    final genoType =
        (bloc.genoType == null) ? widget.plant.genotype : bloc.genoType.trim();

    final sexo = optionItemSelected;

    final quantity =
        (bloc.quantity == null) ? widget.plant.quantity : bloc.quantity.trim();

    final germinated = _dateGController.text;

    final flowering = _dateFController.text;

    final thc = (bloc.thc == null) ? widget.plant.thc : bloc.thc.trim();

    final cbd = (bloc.cbd == null) ? widget.plant.cbd : bloc.cbd.trim();

    final pot = (bloc.pot == null) ? widget.plant.pot : bloc.pot.trim();

    final editPlant = Plant(
        name: name,
        description: description,
        genotype: genoType,
        sexo: sexo,
        quantity: quantity,
        germinated: germinated,
        flowering: flowering,
        thc: thc,
        cbd: cbd,
        pot: pot,
        id: widget.plant.id);

    if (widget.isEdit) {
      final editRoomRes = await plantService.editPlant(editPlant);

      if (editRoomRes != null) {
        if (editRoomRes.ok) {
          // widget.rooms.removeWhere((element) => element.id == editRoomRes.room.id)
          setState(() {
            loading = false;
          });
          // room = editRoomRes.room;

          // roomBloc.getRoom(editRoomRes.room);
          // roomBloc.getRooms(profile.user.uid);
          Navigator.pop(context);
        } else {
          mostrarAlerta(context, 'Error', editRoomRes.msg);
        }
      } else {
        mostrarAlerta(
            context, 'Error del servidor', 'lo sentimos, Intentelo mas tarde');
      }
    }

    //Navigator.pushReplacementNamed(context, '');
  }
}

Route createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        SliverAppBarProfilepPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(-0.5, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}