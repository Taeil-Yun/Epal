//TODO: Refactor this page, please.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:E_Pal/utils/theme.dart';
import 'package:E_Pal/utils/size_config.dart';

class FilterModal extends StatefulWidget {
  //Selected Category (Game) in the Explore page.
  String category;
  FilterModal({this.category, Key key}) : super(key: key);

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  //Scroll Controller
  final ScrollController scrollController = ScrollController();

  //Status Filters
  bool onlineFilter;

  //Gender Filters
  bool femaleFilter;
  bool maleFilter;
  bool nonBinaryFilter;

  //Price Filters
  bool thousandFilter;
  bool fiveThousandFilter;
  bool tenThousandFilter;
  bool twentyThousandFilter;

  @override
  void initState() {
    super.initState();
    initFilters();
  }

  void initFilters() {
    onlineFilter = true;
    femaleFilter = true;
    maleFilter = false;
    nonBinaryFilter = false;
    thousandFilter = true;
    fiveThousandFilter = true;
    tenThousandFilter = true;
    twentyThousandFilter = true;
  }

  @override
  Widget build(BuildContext rootContext) {
    SizeConfig().init(rootContext);
    print("---Category: ${widget.category}");

    return Container(
      height: SizeConfig.safeBlockVertical * 50,
      child: Material(
        child: Navigator(
          onGenerateRoute: (_) {
            return MaterialPageRoute(
              builder: (context2) => Builder(
                builder: (context) => CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: Text(
                      "Filters",
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
                          //Filters Section
                          Expanded(
                            child: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              controller: scrollController,
                              child: Column(
                                children: [
                                  //Status Filter
                                  Wrap(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Status",
                                              style: GoogleFonts.quicksand(
                                                fontSize: 18,
                                              ),
                                            ),
                                            Wrap(
                                              alignment: WrapAlignment.center,
                                              spacing: 10,
                                              children: [
                                                FilterChip(
                                                  label: Text(
                                                    "Online",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  selected: onlineFilter,
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                  selectedColor: PrimaryTheme,
                                                  checkmarkColor: Colors.white,
                                                  onSelected: (isSelected) {
                                                    setState(
                                                      () {
                                                        onlineFilter =
                                                            isSelected;
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(height: 0),
                                  //Gender Filter
                                  Wrap(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Gender",
                                              style: GoogleFonts.quicksand(
                                                fontSize: 18,
                                              ),
                                            ),
                                            Wrap(
                                              alignment: WrapAlignment.center,
                                              spacing: 10,
                                              children: [
                                                FilterChip(
                                                  label: Text(
                                                    "Female",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  selected: femaleFilter,
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                  selectedColor: PrimaryTheme,
                                                  checkmarkColor: Colors.white,
                                                  onSelected: (isSelected) {
                                                    setState(
                                                      () {
                                                        femaleFilter =
                                                            isSelected;
                                                      },
                                                    );
                                                  },
                                                ),
                                                FilterChip(
                                                  label: Text(
                                                    "Male",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  selected: maleFilter,
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                  selectedColor: PrimaryTheme,
                                                  checkmarkColor: Colors.white,
                                                  onSelected: (isSelected) {
                                                    setState(
                                                      () {
                                                        maleFilter = isSelected;
                                                      },
                                                    );
                                                  },
                                                ),
                                                FilterChip(
                                                  label: Text(
                                                    "Non-binary",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  selected: nonBinaryFilter,
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                  selectedColor: PrimaryTheme,
                                                  checkmarkColor: Colors.white,
                                                  onSelected: (isSelected) {
                                                    setState(
                                                      () {
                                                        nonBinaryFilter =
                                                            isSelected;
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(height: 0),
                                  //Price Filter
                                  Wrap(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Price",
                                              style: GoogleFonts.quicksand(
                                                fontSize: 18,
                                              ),
                                            ),
                                            Wrap(
                                              alignment: WrapAlignment.center,
                                              spacing: 10,
                                              children: [
                                                FilterChip(
                                                  label: Text(
                                                    "1.000~5.000",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  selected: thousandFilter,
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                  selectedColor: PrimaryTheme,
                                                  checkmarkColor: Colors.white,
                                                  onSelected: (isSelected) {
                                                    setState(
                                                      () {
                                                        thousandFilter =
                                                            isSelected;
                                                      },
                                                    );
                                                  },
                                                ),
                                                FilterChip(
                                                  label: Text(
                                                    "5.000~10.000",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  selected: fiveThousandFilter,
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                  selectedColor: PrimaryTheme,
                                                  checkmarkColor: Colors.white,
                                                  onSelected: (isSelected) {
                                                    setState(
                                                      () {
                                                        fiveThousandFilter =
                                                            isSelected;
                                                      },
                                                    );
                                                  },
                                                ),
                                                FilterChip(
                                                  label: Text(
                                                    "10.000~20.000",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  selected: tenThousandFilter,
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                  selectedColor: PrimaryTheme,
                                                  checkmarkColor: Colors.white,
                                                  onSelected: (isSelected) {
                                                    setState(
                                                      () {
                                                        tenThousandFilter =
                                                            isSelected;
                                                      },
                                                    );
                                                  },
                                                ),
                                                FilterChip(
                                                  label: Text(
                                                    "20.000~",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  selected:
                                                      twentyThousandFilter,
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                  selectedColor: PrimaryTheme,
                                                  checkmarkColor: Colors.white,
                                                  onSelected: (isSelected) {
                                                    setState(
                                                      () {
                                                        twentyThousandFilter =
                                                            isSelected;
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
                                        initFilters();
                                        scrollController.animateTo(
                                          0,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.decelerate,
                                        );
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          MdiIcons.filterRemove,
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
                                    onPressed: () {
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
