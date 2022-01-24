import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

import '../providers/moments.dart';

class MomentDetailScreen extends StatefulWidget {
  static const routeName = '/moment-detail';

  @override
  _MomentDetailScreenState createState() => _MomentDetailScreenState();
}

class _MomentDetailScreenState extends State<MomentDetailScreen> {
  double _scale = 1.0;
  double _prevScale = 1.0;
  @override
  Widget build(BuildContext context) {
    final momentId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedMoment =
        Provider.of<Moments>(context, listen: false).findById(momentId);
    final nextMoment = Provider.of<Moments>(context, listen: false)
        .findNext(loadedMoment.index);
    final prevMoment = Provider.of<Moments>(context, listen: false)
        .findPrev(loadedMoment.index);
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedMoment.title!),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Theme.of(context).accentColor,
            Theme.of(context).backgroundColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 1],
        )),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.network(loadedMoment.imageUrl!),
              // GestureDetector(
              //   // onScaleStart: (ScaleStartDetails details){
              //   //   _prevScale = _scale;
              //   //   setState(() {});
              //   // },
              //   // onScaleUpdate: (ScaleUpdateDetails details){
              //   //   _scale = _prevScale * details.scale;
              //   //   setState(() {});
              //   // },
              //   // onScaleEnd: (ScaleEndDetails details){
              //   //   _prevScale = 1.0;
              //   //   setState(() {});
              //   // },
              //   child: Padding(
              //     padding: const EdgeInsets.all(2.0),
              //     // child: Transform(
              //     //   alignment: FractionalOffset.center,
              //     //   transform: Matrix4.diagonal3(Vector3(_scale,_scale,_scale)),
              //       //child: Image.network(loadedMoment.imageUrl)
              //       // ),
              //   ),
              //   onDoubleTap: () {},
              // ),
              Center(
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          alignment: Alignment.bottomLeft,
                          onPressed: () {
                            loadedMoment.index == 0
                                ? null
                                : Navigator.of(context).pushReplacementNamed(
                                    MomentDetailScreen.routeName,
                                    arguments: prevMoment.id);
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          alignment: Alignment.bottomRight,
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                                MomentDetailScreen.routeName,
                                arguments: nextMoment.id);
                          },
                        )
                      ],
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              Text(
                loadedMoment.title!,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                width: double.infinity,
                child: Text(
                  loadedMoment.date!,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
