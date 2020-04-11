import 'package:flutter/material.dart';

class PhoneNumGetterDialog extends StatefulWidget {
  @override
  _PhoneNumGetterDialogState createState() => _PhoneNumGetterDialogState();
}

class _PhoneNumGetterDialogState extends State<PhoneNumGetterDialog> {
  var _controller = TextEditingController();
  bool _isNumberValid = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 15, bottom: 10, left: 20, right: 20),
        child: Column(
          textDirection: TextDirection.rtl,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'تاييد شماره تلفن همراه',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'vazir',
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Text(
              '.برای دریافت کد تایید شماره همراه خود را وارد کنید',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'vazir',
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            Text(
              '.دقت کنید شماره وارد شده باید دقیقا 11 رقم باشد*',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'vazir',
                fontWeight: FontWeight.w100,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  '+98',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    minLines: 1,
                    textAlignVertical: TextAlignVertical.bottom,
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        fontFamily: 'vazir',
                        fontSize: 18,
                        fontWeight: FontWeight.w100),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.limeAccent[700],
                          width: 2.0,
                        ),
                      ),
                    ),
                    onChanged: (val) {
                      _isValid();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              disabledColor: Colors.grey[300],
              color: Colors.grey[700],
              elevation: 2,
              onPressed: _isNumberValid
                  ? () {
                      // TODO : complete sms module handelling using blocs
                      Navigator.pop(context);
                    }
                  : null,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              child: Text(
                'تاييد',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'vazir',
                  fontSize: 17,
                  fontWeight: FontWeight.w100,
                  color: _isNumberValid ? Colors.white : Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isValid() {
    setState(() {
      if (_controller.text.trim().length == 11)
        _isNumberValid = true;
      else
        _isNumberValid = false;
    });
    return _isNumberValid;
  }
}
