import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toothpix/response_models/image_upload_model.dart';

class QuickResults extends StatefulWidget {
  static const routeName = 'QuickResult';

  final UploadImageResponse response;

  const QuickResults({this.response});

  @override
  _QuickResultsState createState() => _QuickResultsState();
}

class _QuickResultsState extends State<QuickResults> {
  PageController controller = PageController(
    viewportFraction: 0.9,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Instant Review'),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Theme.of(context).primaryColor,
                  Colors.blue,
                ])),
            child: Stack(
              children: [
                Positioned(
                  top: 16.0,
                  left: -18.0,
                  child: SvgPicture.asset(
                    'assets/blob.svg',
                    width: 78.0,
                    height: 78.0,
                    color: Colors.blue,
                  ),
                ),
                Positioned(
                  top: 32.0,
                  right: 8.0,
                  child: SvgPicture.asset(
                    'assets/blob.svg',
                    width: 78.0,
                    height: 78.0,
                    color: Colors.blue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Hey !',
                        style: GoogleFonts.sourceSansPro(
                            fontSize: 32.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'See the instant review from our AI System. Our doctors will give their expert review in 24 hrs.',
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              child: PageView(
                controller: controller,
                children: [
                  QuickResultsItem(
                    imgUrl: widget.response.imageResponse.topLeft.responseImage,
                    position: 'UL',
                  ),
                  QuickResultsItem(
                    imgUrl:
                        widget.response.imageResponse.topRight.responseImage,
                    position: 'UR',
                  ),
                  QuickResultsItem(
                    imgUrl:
                        widget.response.imageResponse.bottomLeft.responseImage,
                    position: 'LL',
                  ),
                  QuickResultsItem(
                    imgUrl:
                        widget.response.imageResponse.bottomRight.responseImage,
                    position: 'LR',
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuickResultsItem extends StatelessWidget {
  final String imgUrl;
  final String position;

  const QuickResultsItem({this.imgUrl, this.position});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Stack(
              children: [
                Positioned.fill(
                    child: Image.network(
                  imgUrl,
                  fit: BoxFit.fill,
                )),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
