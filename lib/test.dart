void main() {
  print('Hello World!');

  var name = 'Voyager I';
  var year = 1997;
  var antennaDiamter = 3.7;
  var flybyObjects = ['JuPiter', 'Saturn', 'Uranus', 'Neptune'];
  var image = {
    'tags': ['saturn'],
    'url': '//path/to/saturn,jpg'
  };
//------------------------------------------------------------------
  if (year >= 2001) {
    print('21st century');
  } else if (year >= 1901) {
    print('20th centuty');
  }
//------------------------------------------------------------------
  for (var value in flybyObjects) {
    print(value);
  }

  for (int month = 1; month <= 12; month++) {
    print(month);
  }
//------------------------------------------------------------------
  var command = 'CLOSED';
  switch (command) {
    case 'CLOSED':
      // TODO
      continue nowClosed;
    // Continues executing at the nowClosed label.

    nowClosed:
    case 'NOW_CLOSED':
      // Runs for both CLOSED and NOW_CLOSED.
      // TODO
      break;
  }
//------------------------------------------------------------------
  int fibonacci(int n) {
    if (n == 0 || n == 1) {
      return n;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
  }

  print(fibonacci(20));
  // 可以使用函数作为参数
  flybyObjects.where((name) => name.contains('turn')).forEach(print);
//------------------------------------------------------------------
  Spacecraft spacecraft = new Spacecraft('guo', DateTime(1977, 9, 5));
  spacecraft.describe();
  var s2 = Spacecraft.unlaunched('guoguo');
  s2.describe();
}

class Spacecraft {
  String name;
  DateTime launchDate;

  Spacecraft(this.name, this.launchDate);

  Spacecraft.unlaunched(String name) : this(name, null);

  int get launchYear => launchDate?.year;

  void describe() {
    print('Spacecraft:$name');
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched:$launchYear ($years years age)');
    } else {
      print('Unlaunched');
    }
  }
}

class Orbiter extends Spacecraft {
  num altitude;

  Orbiter(String name, DateTime launchDate) : super(name, launchDate);
}
