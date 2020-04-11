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
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: Column(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              textDirection: TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'تاييد شماره تلفن همراه',
                  style: TextStyle(
                    fontFamily: 'vazir',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '.برای دریافت کد تایید شماره همراه خود را وارد کنید',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'vazir',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  '+98',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 15),
                SizedBox(
                  width: 7 * (MediaQuery.of(context).size.width) / 10,
                  child: TextField(
                    maxLength: 11,
                    maxLengthEnforced: false,
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
                            color: Colors.limeAccent[700], width: 2.0),
                      ),
                    ),
                    onChanged: (val) {
                      _isValid();
                    },
                  ),
                ),
              ],
            ),
            RaisedButton(
              padding: EdgeInsets.only(left: 25, right: 20),
              disabledColor: Colors.grey[300],
              color: Colors.grey[700],
              elevation: 2,
              onPressed: _isNumberValid ? () {} : null,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
                side: BorderSide(
                    color:
                        _isNumberValid ? Colors.grey[700] : Colors.grey[300]),
              ),
              child: Text(
                'تاييد',
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
    ));
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
