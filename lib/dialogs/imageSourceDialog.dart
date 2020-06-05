import 'package:flutter/material.dart';
import 'package:pishgamv2/constants/Constants.dart';

class ImageSourceDialog extends StatelessWidget {
  const ImageSourceDialog(
      {@required this.onCamera, @required this.onGallery});

  final Function onCamera;
  final Function onGallery;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: DialogShape,
      title: Text(
        "انتخاب کنید",
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontFamily: 'vazir',
          fontWeight: FontWeight.w500,
        ),
      ),
//      content: Text(
//        content != null ? content : '',
//        textDirection: TextDirection.rtl,
//        style: TextStyle(
//          fontFamily: 'vazir',
//          fontWeight: FontWeight.w100,
//        ),
//      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: RaisedButton(
            child: Text(
              'دوربین',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'vazir',
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              if (onCamera != null) onCamera();
            },
            color: Colors.grey[700],
            shape: DialogShape,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: RaisedButton(
            child: Text(
              'گالری',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'vazir',
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              if (onGallery != null) onGallery();
            },
            color: Colors.grey[700],
            shape: DialogShape,
          ),
        ),
      ],
    );
  }
}

class WaiterDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(scaffoldDefaultBackgroundColor),
        ),
      ),
    );
  }
}
