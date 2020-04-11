import 'package:flutter/material.dart';

class PhoneNumberVerification extends StatefulWidget {
  @override
  _PhoneNumberVerificationState createState() => _PhoneNumberVerificationState();
}

class _PhoneNumberVerificationState extends State<PhoneNumberVerification> {

  var _controller = TextEditingController();
  bool  _isNumberValid=false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(

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
                        fontFamily:'VazirMedium',
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '.برای دریافت کد تایید شماره همراه خود را وارد کنید',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'VazirMedium',
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('+98',style: TextStyle(fontSize: 14)),
                    SizedBox(width: 15),
                    SizedBox(
                      width: 7*(MediaQuery.of(context).size.width)/10,
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.phone,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.limeAccent[700], width: 2.0),
                          ),
                        ),
                        onChanged: (val){
                          _isValid();
                        },
                      ),
                    ),
                  ],
                ),
                RaisedButton(
                  padding: EdgeInsets.only(left: 25,right: 20),
                  disabledColor: Colors.grey[300],
                  color: Colors.grey[700],
                  elevation: 2,
                  onPressed: _isNumberValid? (){} : null,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: _isNumberValid? Colors.grey[700]: Colors.grey[300])
                  ),
                  child: Text(
                    'تاييد',
                    style: TextStyle(
                      fontFamily: 'VazirMedium',
                      fontSize: 17,
                      fontWeight: FontWeight.w100,
                      color:_isNumberValid? Colors.white: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  bool _isValid(){
    setState(() {
      if(_controller.text.trim().length == 10) _isNumberValid=true;
      else _isNumberValid=false;
    });
    return _isNumberValid;
  }
}
