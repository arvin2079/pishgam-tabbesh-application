import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';

class TwoPanels extends StatefulWidget {
  final AnimationController controller;

  TwoPanels({this.controller}) {}

  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends State<TwoPanels> {
  static const header_height = 4.0;
  int _current = 0;
  List imagelist = [
    'https://cdn.thewire.in/wp-content/uploads/2018/03/15152539/tom-and-jerry-.jpg',
    'https://images-na.ssl-images-amazon.com/images/I/81WS5YsKmML._SX268_.jpg'
  ];

  List<T> map<T>(List list, Function function) {
    List<T> result = [];
    for (var i = 0; i < imagelist.length; i++) {
      result.add(function(i, imagelist[i]));
    }
    return result;
  }

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = 280.0;
    final bakcpanelheight = height - header_height;
    final frontpanelheight = header_height;
    String time;

    return new RelativeRectTween(
      begin: new RelativeRect.fromLTRB(0, bakcpanelheight, 0, frontpanelheight),
      end: new RelativeRect.fromLTRB(0, 0, 0, 0),
    ).animate(CurvedAnimation(parent: widget.controller, curve: Curves.linear));
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    final ThemeData theme = Theme.of(context);
    return new Container(
      child: new Stack(
        children: <Widget>[
          new Container(
            color: theme.primaryColor,
            child: Container(
              child: new Center(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'احسان رضایی',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'سوم دبیرستان',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 70.0,
                          height: 70.0,
                          child: Icon(Icons.person),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    new Container(
                      width: 280.0,
                      height: 110.0,
                      child: new Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(40.0),
                              topRight: const Radius.circular(40.0),
                            )),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'مانده تا شروع کلاس ',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              'مانده تا شروع کلاس استاد شهریاری',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            MaterialButton(
                              onPressed: () {},
                              color: Colors.blue,
                              child: Icon(
                                Icons.people,
                                size: 24,
                                color: Colors.black,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            Text(
                              'درباره ی ما',
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            MaterialButton(
                              onPressed: () {},
                              color: Colors.blue,
                              child: Icon(Icons.settings,
                                  size: 24, color: Colors.black),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            Text(
                              'تنطیمات',
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          PositionedTransition(
            rect: getPanelAnimation(constraints),
            child: new Material(
              elevation: 12.0,
              borderRadius: new BorderRadius.only(
                topLeft: new Radius.circular(16.0),
                topRight: new Radius.circular(16.0),
              ),
              child: Column(
                children: <Widget>[
                  new Container(
                    height: header_height,
                    child: new Center(
                      child: new Text(
                        'shop here',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                  Container(
                    child: new Expanded(
                        child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Divider(
                          height: 10.0,
                          thickness: 5.0,
                          endIndent: 100.0,
                          indent: 100,
                          color: Colors.black,
                        ),
                        CarouselSlider(
                            height: 400,
                            initialPage: 0,
                            enlargeCenterPage: true,
                            reverse: false,
                            autoPlayInterval: Duration(),
                            onPageChanged: (index) {
                              setState(() {
                                _current = index;
                              });
                            },
                            items: imagelist.map((imgUrl) {
                              return Builder(builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                  ),
                                  child: Image.network(
                                    imgUrl,
                                    fit: BoxFit.fill,
                                  ),
                                );
                              });
                            }).toList()),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: map<Widget>(imagelist, (index, url) {
                              return Container(
                                width: 10.0,
                                height: 10.0,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 2.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == index
                                      ? Colors.black
                                      : Colors.blueGrey,
                                ),
                              );
                            }))
                      ],
                    )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
      builder: bothPanels,
    );
  }
}
