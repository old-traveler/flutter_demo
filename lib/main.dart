import 'dart:ui';
import 'package:flutter/material.dart';

import 'line_chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Demo'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: LineChart(
            size: Size(90 * 3.0, 34 * 3.0),
            values: <double>[100, 90, 110, 100, 105, 110, 110],
            strokeWidth: 2,
          ),
          color: Colors.white,
        ));
  }
}

class ExpandedText extends StatefulWidget {
  final InlineSpan inlineSpan;
  final int maxLines;

  ExpandedText({Key key, this.inlineSpan, this.maxLines: 4}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ExpandedTextState();
  }
}

class _ExpandedTextState extends State<ExpandedText> {
  final TextPainter textPainter = TextPainter();
  int maxLines;

  @override
  void initState() {
    super.initState();
    textPainter.textDirection = TextDirection.ltr;
    textPainter.text = widget.inlineSpan;
    maxLines = widget.maxLines;
  }

  @override
  void didUpdateWidget(ExpandedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    textPainter.text = widget.inlineSpan;
    maxLines = widget.maxLines;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        textPainter.maxLines = maxLines;
        textPainter.layout(maxWidth: box.maxWidth);
        Widget child = Text.rich(
          widget.inlineSpan,
          maxLines: maxLines,
        );
        if (textPainter.didExceedMaxLines) {
          return _buildFoldText(child);
        } else if (maxLines == null) {
          return Text.rich(TextSpan(children: <InlineSpan>[
            widget.inlineSpan,
            WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: GestureDetector(
                    child: Text(
                      '收起',
                      style: TextStyle(color: Colors.blue, fontSize: 13),
                    ),
                    onTap: () => setState(() => maxLines = widget.maxLines),
                  ),
                ))
          ]));
        } else {
          return child;
        }
      },
    );
  }

  Widget _buildFoldText(Widget child) {
    return Stack(
      children: <Widget>[
        child,
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            alignment: Alignment.centerRight,
            width: 50,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0x00FCFCFC),
              Color(0xFFF8F8F8),
              Color(0xFFF8F8F8),
              Color(0xFFF8F8F8),
              Color(0xFFF8F8F8),
            ])),
            child: GestureDetector(
              child: Text(
                '全文',
                style: TextStyle(color: Colors.blue, fontSize: 13),
              ),
              onTap: () => setState(() => maxLines = null),
            ),
          ),
        )
      ],
    );
  }
}
