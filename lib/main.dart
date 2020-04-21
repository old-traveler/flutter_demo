
void main() async {
  methodA();
  methodB();//和原demo比这里去掉了await
  methodC('main');//和原demo比这里去掉了await
  methodD();
}

methodA(){
  print('A');
}
methodB() async {
  print('B start');
  await methodC('B');
  print('B end');
}
methodC(String from) async {
  print('C start from $from');

  Future((){                // <== 该代码将在未来的某个时间段执行
    print('C running Future from $from');
  }).then((_){
    print('C end of Future from $from');
  });

  print('C end from $from');
}
methodD(){
  print('D');
}