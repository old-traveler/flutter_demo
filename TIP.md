
```dart
  Widget buildDivider(BuildContext context){
   Divider(
        height: 50, //空间
        thickness: 20, // 线条
        indent: 20, //左边空间
        endIndent: 20,//右边空间
        color: Colors.white, //颜色
      );
  }
```
```
  final controller = scaffoldState.showBottomSheet<T>((_) {
      return Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(scaffoldState.context).padding.bottom),
        child: child,
      );
   }, backgroundColor: backgroundColor);
```

