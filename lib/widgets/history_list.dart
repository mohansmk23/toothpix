import 'package:flutter/material.dart';
import 'package:toothpix/response_models/history_list.dart';
import 'package:toothpix/widgets/historyCard.dart';

class HistoryListView extends StatelessWidget {
  final List<History> historyList;

  const HistoryListView({this.historyList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: historyList.length,
      itemBuilder: (context, index) {
        return HistoryCard(
          history: historyList[index],
        );
      },
    );
  }
}
