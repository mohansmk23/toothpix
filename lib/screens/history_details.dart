import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toothpix/backend/api_urls.dart';
import 'package:toothpix/connection/connection.dart';
import 'package:toothpix/constants/sharedPrefKeys.dart';
import 'package:toothpix/response_models/history_details_model.dart';
import 'package:toothpix/screens/quick_results_screen.dart';
import 'package:toothpix/widgets/historyCard.dart';
import 'package:toothpix/widgets/history_date_card.dart';

enum ProblemResult { positive, negative }
enum ProblemType { cavity, filling }

class HistoryDetails extends StatefulWidget {
  final String recommendDate;
  final String id;
  final RecommendationStatus status;

  HistoryDetails({this.recommendDate, this.id, this.status});

  static const routeName = "/historydetails";

  @override
  _HistoryDetailsState createState() => _HistoryDetailsState();
}

class _HistoryDetailsState extends State<HistoryDetails> {
  final _pageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 0.9);

  bool _isLoading = false;

  HistoryDetailsResponse historyDetailsResponse;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
  }

  getHistoryDetails() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, String> params = {"id": widget.id};
    try {
      var preferences = await SharedPreferences.getInstance();
      final response = await getDio(key: preferences.getString(authkey))
          .post(historyDetailsUrl, data: params);
      historyDetailsResponse =
          HistoryDetailsResponse.fromJson(json.decode(response.data));
      if (historyDetailsResponse.status == 'success') {
      } else {
        _showSnackBar('Something Went Wrong');
      }
    } catch (e) {
      print(e);
      _showSnackBar('Network Error');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getHistoryDetails();
  }

  _getPositionNameFromIndex(int index) {
    switch (index) {
      case 0:
        return 'UL';
        break;
      case 1:
        return 'UR';
        break;
      case 2:
        return 'LL';
        break;
      case 3:
        return 'LR';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          List<String> response = [];

          response.add(widget.id);
          response.add(historyDetailsResponse.imageDetails[0].url);
          response.add(historyDetailsResponse.imageDetails[1].url);
          response.add(historyDetailsResponse.imageDetails[2].url);
          response.add(historyDetailsResponse.imageDetails[3].url);

          var result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => QuickResults(
                response: response,
              ),
            ),
          );

          if (result != null && result) {
            _showSnackBar('something went wrong');
          }
        },
        label: Text(
          'Instant AI Review',
        ),
        icon: Icon(Icons.lightbulb_outline),
      ),
      appBar: AppBar(
        title: Text('ToothPix'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    HistoryDetailsDateCard(
                        recommendDate: widget.recommendDate,
                        uploadDate:
                            historyDetailsResponse.imageDetails[0].createdAt),
                    SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width + 72 + 200,
                      child: PageView.builder(
                        itemCount: 4,
                        controller: _pageController,
                        itemBuilder: (BuildContext context, int index) {
                          ImageDetails imageData =
                              historyDetailsResponse.imageDetails[index];

                          return HistoryDetailsCard(
                              position: _getPositionNameFromIndex(index),
                              isCavity: imageData.cavity == 'Yes',
                              isFilling: imageData.brokenFiling == 'Yes',
                              recommendation: imageData.comments,
                              imgUrl: imageData.url,
                              quickImageUrl: imageData.responseImage,
                              status: widget.status);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class HistoryDetailsCard extends StatelessWidget {
  final String position;
  final bool isCavity;
  final bool isFilling;
  final String recommendation;
  final String imgUrl;
  final RecommendationStatus status;
  final String quickImageUrl;

  const HistoryDetailsCard(
      {this.position,
      this.isCavity,
      this.isFilling,
      this.recommendation,
      this.imgUrl,
      this.status,
      this.quickImageUrl});

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0)),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            imgUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: 16.0,
                          right: 8.0,
                          child: ClipOval(
                            child: Container(
                              color: Colors.black.withOpacity(0.25),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  position,
                                  style: GoogleFonts.sourceSansPro(
                                      fontSize: 24.0, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   left: 4.0,
                        //   top: 4.0,
                        //   child: InkWell(
                        //     onTap: () {
                        //       showGeneralDialog(
                        //         context: context,
                        //         barrierColor: Colors.black12
                        //             .withOpacity(0.6), // background color
                        //         barrierDismissible:
                        //             false, // should dialog be dismissed when tapped outside
                        //         barrierLabel: "Dialog", // label for barrier
                        //         transitionDuration: Duration(
                        //             milliseconds:
                        //                 400), // how long it takes to popup dialog after button click
                        //         pageBuilder: (_, __, ___) {
                        //           // your widget implementation
                        //           return SizedBox.expand(
                        //             // makes widget fullscreen
                        //             child: Column(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.end,
                        //               children: <Widget>[
                        //                 GestureDetector(
                        //                   onTap: () {
                        //                     Navigator.pop(context);
                        //                   },
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.all(16.0),
                        //                     child: Icon(
                        //                       Icons.close,
                        //                       color: Colors.white,
                        //                       size: 32.0,
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 AspectRatio(
                        //                   aspectRatio: 1 / 1,
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.all(16.0),
                        //                     child: Image.network(
                        //                       quickImageUrl,
                        //                       fit: BoxFit.fill,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           );
                        //         },
                        //       );
                        //     },
                        //     child: Card(
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(16.0)),
                        //       child: Padding(
                        //         padding: const EdgeInsets.symmetric(
                        //             horizontal: 8.0, vertical: 2.0),
                        //         child: Row(
                        //           mainAxisSize: MainAxisSize.min,
                        //           children: [
                        //             Icon(
                        //               FontAwesome.info,
                        //               size: 14.0,
                        //             ),
                        //             SizedBox(
                        //               width: 4.0,
                        //             ),
                        //             Text(
                        //               'Instant AI Review',
                        //               style: GoogleFonts.sourceSansPro(
                        //                   fontSize: 12.0,
                        //                   fontWeight: FontWeight.w600),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ))),
            SizedBox(
              height: 16.0,
            ),
            status == RecommendationStatus.pending
                ? PendingApprovalIndicator()
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProblemIndicator(
                                type: ProblemType.cavity,
                                result: isCavity
                                    ? ProblemResult.positive
                                    : ProblemResult.negative,
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              ProblemIndicator(
                                type: ProblemType.filling,
                                result: isFilling
                                    ? ProblemResult.positive
                                    : ProblemResult.negative,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            'Recommendation',
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 12.0, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Expanded(
                            child: Scrollbar(
                              isAlwaysShown: true,
                              controller: _scrollController,
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                child: Text(
                                  recommendation.isEmpty
                                      ? 'No Recommendation'
                                      : recommendation,
                                  style:
                                      GoogleFonts.sourceSansPro(fontSize: 15.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class PendingApprovalIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 1.0, bottom: 16.0, right: 32.0, left: 16.0),
      child: Container(
        color: Colors.orange[100],
        child: Row(
          children: [
            Container(
              height: 28.0,
              width: 6.0,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            SizedBox(
              width: 4.0,
            ),
            Icon(
              Icons.warning_amber_outlined,
              color: Colors.orange,
            ),
            SizedBox(
              width: 16.0,
            ),
            Text(
              'Pending For Expert Review',
              style: GoogleFonts.sourceSansPro(
                  color: Colors.orange, fontSize: 16.0),
            ),
            SizedBox(
              width: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}

class ProblemIndicator extends StatelessWidget {
  final ProblemResult result;
  final ProblemType type;

  const ProblemIndicator({this.result, this.type});

  getProblemText() {
    if (type == ProblemType.cavity) {
      if (result == ProblemResult.positive) {
        return 'Cavity Detected';
      } else {
        return 'No Cavity Detected';
      }
    } else {
      if (result == ProblemResult.positive) {
        return 'Need Filling';
      } else {
        return 'No Filling Needed';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: result == ProblemResult.positive
            ? Colors.red[100]
            : Colors.green[100],
        child: Row(
          children: [
            Container(
              height: 28.0,
              width: 6.0,
              decoration: BoxDecoration(
                color: result == ProblemResult.positive
                    ? Colors.red
                    : Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            SizedBox(
              width: 4.0,
            ),
            SvgPicture.asset(
              type == ProblemType.filling
                  ? 'assets/tooth-filling.svg'
                  : 'assets/cavity.svg',
              color:
                  result == ProblemResult.positive ? Colors.red : Colors.green,
              width: 20.0,
              height: 20.0,
            ),
            SizedBox(
              width: 4.0,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  getProblemText(),
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.sourceSansPro(
                      color: result == ProblemResult.positive
                          ? Colors.red
                          : Colors.green,
                      fontSize: 12.0),
                ),
              ),
            ),
            SizedBox(
              width: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
