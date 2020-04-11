import 'package:flutter/material.dart';

class PhoneNumVerifierDialog extends StatefulWidget {
  @override
  _PhoneNumVerifierDialogState createState() => _PhoneNumVerifierDialogState();
}

class _PhoneNumVerifierDialogState extends State<PhoneNumVerifierDialog> {
  final _controller = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 15, bottom: 10, left: 20, right: 20),
        child: Column(
          textDirection: TextDirection.rtl,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'كد تاييد را وارد كنيد',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'vazir',
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              'کد تایید به شماره همراه شما ارسال شد',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'vazir',
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            TextField(
              onChanged: (val) {
                _isValid();
              },
              textAlign: TextAlign.center,
              controller: _controller,
              keyboardType: TextInputType.number,
              style: TextStyle(
                  fontFamily: 'vazir',
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.limeAccent[700], width: 2.0),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'ارسال دوباره',
                    style: TextStyle(
                      fontFamily: 'vazir',
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.grey[700],
                    ),
                  ),
                  onPressed: () {
                    //TODO : handel later with blocs
                    Navigator.pop(context);
                  },
                ),
                RaisedButton(
                  disabledColor: Colors.grey[300],
                  child: Text(
                    'تاييد',
                    style: TextStyle(
                      fontFamily: 'vazir',
                      fontSize: 17,
                      fontWeight: FontWeight.w100,
                      color: _isButtonEnabled ? Colors.white : Colors.grey[700],
                    ),
                  ),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  color: Colors.grey[700],
                  elevation: 2,
                  onPressed: _isButtonEnabled ? () {
                    //TODO : handel later with blocs
                    Navigator.pop(context);
                  } : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _isValid() {
    setState(() {
      if (_controller.text.trim().length > 0)
        _isButtonEnabled = true;
      else
        _isButtonEnabled = false;
    });
    return _isButtonEnabled;
  }
}
