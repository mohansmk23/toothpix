import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toothpix/app/widget_constants.dart';
import 'package:toothpix/backend/api_urls.dart';
import 'package:toothpix/connection/connection.dart';
import 'package:toothpix/constants/sharedPrefKeys.dart';
import 'package:toothpix/response_models/history_details_model.dart';
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HistoryDetailsDateCard(
                        recommendDate: widget.recommendDate,
                        uploadDate:
                            historyDetailsResponse.imageDetails[0].createdAt),
                    SizedBox(
                      height: 24.0,
                    ),
                    Expanded(
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
                            status: widget.status,
                          );
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

  const HistoryDetailsCard(
      {this.position,
      this.isCavity,
      this.isFilling,
      this.recommendation,
      this.imgUrl,
      this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: neumorphicShadow,
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
                                            fontSize: 24.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))),
                  SizedBox(
                    height: 16.0,
                  ),
                  status == RecommendationStatus.pending
                      ? PendingApprovalIndicator()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
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
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                recommendation.isEmpty
                                    ? 'No Recommendation'
                                    : recommendation,
                                style:
                                    GoogleFonts.sourceSansPro(fontSize: 15.0),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ],
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
              'Pending For Review',
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
    return Container(
      color: result == ProblemResult.positive
          ? Colors.red[100]
          : Colors.green[100],
      child: Row(
        children: [
          Container(
            height: 28.0,
            width: 6.0,
            decoration: BoxDecoration(
              color:
                  result == ProblemResult.positive ? Colors.red : Colors.green,
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
            color: result == ProblemResult.positive ? Colors.red : Colors.green,
            width: 20.0,
            height: 20.0,
          ),
          SizedBox(
            width: 4.0,
          ),
          Text(
            getProblemText(),
            style: GoogleFonts.sourceSansPro(
                color: result == ProblemResult.positive
                    ? Colors.red
                    : Colors.green,
                fontSize: 12.0),
          ),
          SizedBox(
            width: 16.0,
          ),
        ],
      ),
    );
  }
}
