import 'dart:io';
main(){

  String name;
  int age;

  stdout.write('Enter your Name: ');
  name = stdin.readLineSync()!;
  stdout.write('Enter your age: ');
  String? input = stdin.readLineSync()!;
  age = int.parse(input);

  if(age < 18){
    print('Sorry $name, You are not Eligible to vote.');
  }
  else{
    print('Congratulation $name, You are Eligible to vote.');
  }


}