
## buildPage secondaryAnimation的含义
```dart
 Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    secondaryAnimation.addListener(() {
      print('secondaryAnimation ${secondaryAnimation.value}');
    });
    animation.addListener(() {
      print('animation ${animation.value}');
    });
    return SlideTransition(
        position:
            Tween(begin: Offset(0.0, 1.0), end: Offset.zero).animate(animation),
        child: SlideTransition(
            position: Tween(begin: Offset.zero, end: Offset(0.0, -1.0))
                .animate(secondaryAnimation),
            child: bottom));
  }
```
现象

* 当此Route第一次被push时secondaryAnimation不会被触发，仅触发animation(0.0-1.0)
* 当此Route位于栈顶时有新的Route被push，此时secondaryAnimation(0.0-1.0)被触发 不触发animation
* 当此Route重新回到栈顶时secondaryAnimation(1.0-0.0)被触发,不触发animation
* 当此Route被pop时触发animation(1.0-0.0)，不触发secondaryAnimation

结论
* secondaryAnimation用于给栈顶元素改变时(非入栈或出栈)添加动画
* 正常的入栈出栈不会触发secondaryAnimation
* 同一Route实例的animation 和 secondaryAnimation不会同时触发
