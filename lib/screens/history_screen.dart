import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toothpix/backend/api_urls.dart';
import 'package:toothpix/connection/connection.dart';
import 'package:toothpix/constants/sharedPrefKeys.dart';
import 'package:toothpix/response_models/history_list.dart';
import 'package:toothpix/widgets/TabIndicator.dart';
import 'package:toothpix/widgets/historyCard.dart';
import 'package:toothpix/widgets/history_list.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = "/history";
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _isLoading = false;
  HistoryResponse historyListResponse;
  List<History> recommendedList = [];
  List<History> pendingList = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
  }

  getHistory() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, String> params = {};
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final response = await getDio(key: preferences.getString(authkey))
          .post(historyList, data: params);
      historyListResponse =
          HistoryResponse.fromJson(json.decode(response.data));
      if (historyListResponse.status == 'success') {
        organiseHistoryList(historyListResponse);
      } else {
        _showSnackBar(historyListResponse.message);
      }
    } catch (e) {
      print(e);
      _showSnackBar('Network Error');
    }
    setState(() {
      _isLoading = false;
    });
  }

  organiseHistoryList(HistoryResponse response) {
    for (History currentHistory in response.history) {
      if (currentHistory.recommentStatus == 'Yes') {
        recommendedList.add(currentHistory);
      } else {
        pendingList.add(currentHistory);
      }
    }
  }

  @override
  void initState() {
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('History of ToothPix'),
          bottom: TabBar(
            indicator: CircleTabIndicator(color: Colors.white, radius: 3),
            unselectedLabelColor: Colors.grey[350],
            tabs: <Widget>[
              Tab(
                child: Text(
                  'All',
                  style: GoogleFonts.lato(),
                ),
              ),
              Tab(
                child: Text('Recommended'),
              ),
              Tab(
                child: Text('Pending'),
              ),
            ],
          ),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(
                children: <Widget>[
                  historyListResponse.history.isEmpty
                      ? HistoryEmptyState(status: RecommendationStatus.all)
                      : HistoryListView(
                          historyList: historyListResponse.history,
                        ),
                  recommendedList.isEmpty
                      ? HistoryEmptyState(
                          status: RecommendationStatus.recommended)
                      : HistoryListView(
                          historyList: recommendedList,
                        ),
                  pendingList.isEmpty
                      ? HistoryEmptyState(status: RecommendationStatus.pending)
                      : HistoryListView(
                          historyList: pendingList,
                        ),
                ],
              ),
      ),
    );
  }
}

class HistoryEmptyState extends StatelessWidget {
  final RecommendationStatus status;

  const HistoryEmptyState({this.status});

  String getEmptyStateHeadText(RecommendationStatus status) {
    switch (status) {
      case RecommendationStatus.all:
        return 'No ToothPix Available';
        break;
      case RecommendationStatus.recommended:
        return 'No Recommended ToothPix';
        break;
      case RecommendationStatus.pending:
        return 'No Pending ToothPix';
        break;
    }
  }

  String getEmptyStateSubText(RecommendationStatus status) {
    switch (status) {
      case RecommendationStatus.all:
        return 'Take new ToothPix to See Results';
        break;
      case RecommendationStatus.recommended:
        return 'Check This Space Later';
        break;
      case RecommendationStatus.pending:
        return 'Take new ToothPix to See Results';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/no_pending.svg',
          height: 200.0,
        ),
        SizedBox(
          height: 16.0,
        ),
        Text(
          getEmptyStateHeadText(status),
          style: GoogleFonts.sourceSansPro(
              fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
        Text(
          getEmptyStateSubText(status),
          style: GoogleFonts.sourceSansPro(
              fontSize: 16.0, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
