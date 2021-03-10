import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toothpix/response_models/history_list.dart';
import 'package:toothpix/screens/history_details.dart';

enum RecommendationStatus {
  all,
  recommended,
  pending,
}

class HistoryCard extends StatelessWidget {
  final History history;

  const HistoryCard({this.history});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryDetails(
                    recommendDate: history.recommentationDate,
                    id: history.id,
                    status: history.recommentStatus == 'Yes'
                        ? RecommendationStatus.recommended
                        : RecommendationStatus.pending,
                  ),
                ));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatusColorIndicator(
                      status: history.recommentStatus == 'Yes'
                          ? RecommendationStatus.recommended
                          : RecommendationStatus.pending),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          history.uploadDate,
                          style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.w800, fontSize: 18.0),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        FourImageTiles(
                          history: history,
                        )
                      ],
                    ),
                  ),
                  StatusTag(
                    status: history.recommentStatus == 'Yes'
                        ? RecommendationStatus.recommended
                        : RecommendationStatus.pending,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StatusColorIndicator extends StatelessWidget {
  final RecommendationStatus status;

  const StatusColorIndicator({this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6.0,
      height: 42.0,
      decoration: BoxDecoration(
        color: status == RecommendationStatus.recommended
            ? Colors.green
            : Colors.orange,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}

class StatusTag extends StatelessWidget {
  final RecommendationStatus status;

  const StatusTag({this.status});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: status == RecommendationStatus.recommended
            ? Colors.green[100]
            : Colors.orange[100],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FontAwesome.check_circle,
              color: status == RecommendationStatus.recommended
                  ? Colors.green
                  : Colors.orange,
            ),
            SizedBox(
              width: 4.0,
            ),
            Text(
              status == RecommendationStatus.recommended
                  ? 'Reviewed'
                  : 'Pending',
              style: GoogleFonts.sourceSansPro(
                  color: status == RecommendationStatus.recommended
                      ? Colors.green
                      : Colors.orange,
                  fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}

class FourImageTiles extends StatelessWidget {
  final History history;

  const FourImageTiles({this.history});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: new Container(
              height: 30.0,
              width: 30.0,
              child: new Image.network(
                history.imageUrl[0].topLeft,
                fit: BoxFit.fill,
              )),
        ),
        Transform.translate(
          offset: Offset(-4.0, 0.0),
          child: ClipOval(
            child: new Container(
                height: 30.0,
                width: 30.0,
                child: new Image.network(
                  history.imageUrl[1].topRight,
                  fit: BoxFit.fill,
                )),
          ),
        ),
        Transform.translate(
          offset: Offset(-6.0, 0.0),
          child: ClipOval(
            child: new Container(
                height: 30.0,
                width: 30.0,
                child: new Image.network(
                  history.imageUrl[2].bottomLeft,
                  fit: BoxFit.fill,
                )),
          ),
        ),
        Transform.translate(
          offset: Offset(-8.0, 0.0),
          child: ClipOval(
            child: new Container(
                height: 30.0,
                width: 30.0,
                child: new Image.network(
                  history.imageUrl[3].bottomRight,
                  fit: BoxFit.fill,
                )),
          ),
        ),
      ],
    );
  }
}
