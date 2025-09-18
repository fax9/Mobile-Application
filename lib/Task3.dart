import 'dart:io';
void main(){

  int N;
  int even=0;
  int odd=0;
  int? largest = null;
  int? smallest = null;

  stdout.write('How many numbers you wanna Enter: ');
  String? input = stdin.readLineSync();
  N = int.parse(input!);

  List <int> numbers = List.filled(N, 0);

  for(int i=0; i<N; i++){
    stdout.write('Enter the Numbers ${i+1}: ');
    int num = int.parse(stdin.readLineSync()!);
    numbers[i] = num;

    if(num%2==0){
      even = even + num;
    }
    if(num%2==1){
      odd = odd + num;

    }
    if( largest == null || num >largest){
      largest = num;
    }

    if( smallest == null || num <smallest){
      smallest = num;
    }

  }
  print('The Sum of Even numbers is: $even');
  print('The Sum of Odd numbers is: $odd');
  print('The Largest numbers is: $largest');
  print('The Smallest numbers is: $smallest');

}