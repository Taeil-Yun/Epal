import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:E_Pal/utils/theme.dart';
import 'package:E_Pal/utils/size_config.dart';

class SortByModal extends StatefulWidget {
  const SortByModal({Key key}) : super(key: key);

  @override
  _SortByModalState createState() => _SortByModalState();
}

class _SortByModalState extends State<SortByModal> {
  //Scroll Controller
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  //Sort
  List<String> _choices;
  List<Icon> _choicesIcons;
  int _choice;

  @override
  void initState() {
    super.initState();
    initSort();
  }

  void initSort() {
    _choices = [
      "Popular",
      "Rating",
      "Low Price",
      "High Price",
    ];
    _choicesIcons = [
      Icon(
        MdiIcons.fire,
        size: 20,
        color: Colors.white,
      ),
      Icon(
        MdiIcons.starBox,
        size: 20,
        color: Colors.white,
      ),
      Icon(
        MdiIcons.arrowDownCircle,
        size: 20,
        color: Colors.white,
      ),
      Icon(
        MdiIcons.arrowUpCircle,
        size: 20,
        color: Colors.white,
      ),
    ];
    _choice = 0;
  }

  @override
  Widget build(BuildContext rootContext) {
    SizeConfig().init(rootContext);

    return Container(
      height: SizeConfig.safeBlockVertical * 35,
      child: Material(
        child: Navigator(
          onGenerateRoute: (_) {
            return MaterialPageRoute(
              builder: (context2) => Builder(
                builder: (context) => CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: Text(
                      "Sort By",
                      style: GoogleFonts.quicksand(fontSize: 18),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        MdiIcons.closeCircle,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.of(rootContext).pop();
                      },
                    ),
                  ),
                  child: SafeArea(
                    child: Container(
                      child: Column(
                        children: [
                          //Sort Section
                          Expanded(
                            child: ScrollablePositionedList.builder(
                              physics: ClampingScrollPhysics(),
                              itemCount: _choices.length,
                              itemBuilder: (context, index) {
                                return Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ChoiceChip(
                                        avatar: _choicesIcons[index],
                                        label: Text(
                                          _choices[index],
                                          style: GoogleFonts.quicksand(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        backgroundColor: Colors.grey[400],
                                        selectedColor: PrimaryTheme,
                                        selected: _choice == index,
                                        onSelected: (isSelected) {
                                          setState(() {
                                            _choice = index;
                                            itemScrollController.scrollTo(
                                              alignment: _choice == 0
                                                  ? 0
                                                  : _choice == 3
                                                      ? 0.53
                                                      : 0.25,
                                              index: _choice,
                                              duration:
                                                  Duration(milliseconds: 200),
                                              curve: Curves.decelerate,
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                    Divider(height: 0),
                                  ],
                                );
                              },
                              itemScrollController: itemScrollController,
                              itemPositionsListener: itemPositionsListener,
                            ),
                          ),
                          Divider(
                            height: 0,
                          ),
                          //Buttons Section
                          Container(
                            padding: EdgeInsets.only(
                                top: SizeConfig.safeBlockVertical * 1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 35,
                                  height: 37,
                                  child: RaisedButton(
                                    elevation: 0,
                                    color: Colors.grey[400],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        initSort();
                                        itemScrollController.scrollTo(
                                            index: 0,
                                            duration:
                                                Duration(milliseconds: 200),
                                            curve: Curves.decelerate);
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          MdiIcons.sortVariantRemove,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "RESET",
                                          style: GoogleFonts.quicksand(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 35,
                                  height: 37,
                                  child: RaisedButton(
                                    elevation: 0,
                                    color: PrimaryTheme,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    onPressed: () async {
                                      await itemScrollController.scrollTo(
                                          alignment: _choice == 0
                                              ? 0
                                              : _choice == 3
                                                  ? 0.53
                                                  : 0.25,
                                          index: _choice,
                                          duration: Duration(milliseconds: 200),
                                          curve: Curves.decelerate);
                                      Navigator.of(rootContext).pop();
                                    },
                                    child: Text(
                                      "CONFIRM",
                                      style: GoogleFonts.quicksand(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
