import 'dart:io';

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
//------------------------------------------------------------------
  Orbiter orbiter = new Orbiter('t', DateTime(2001, 9, 5));
  orbiter.describe();
  orbiter.describerCrew();

  printWithDelay('异步');
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

class Piloted {
  int astronauts = 1;

  void describerCrew() {
    print('Number of astronauts: $astronauts');
  }
}

class Orbiter extends Spacecraft with Piloted {
  num altitude;

  Orbiter(String name, DateTime launchDate) : super(name, launchDate);
}

class MockSpaceship implements Spacecraft {
  @override
  DateTime launchDate;

  @override
  String name;

  @override
  void describe() {
    // TODO: implement describe
  }

  @override
  // TODO: implement launchYear
  int get launchYear => null;
}

abstract class Describable {
  void describe();

  void describeWithEmphasis() {
    print('===========');
    describe();
    print('===========');
  }
}

const oneSecond = Duration(seconds: 5);

Future<void> printWithDelay(String message) async {
  await Future.delayed(oneSecond);
  print('--->$message');
}

Future<void> printWithDelay2(String message) {
  return Future.delayed(oneSecond).then((_) {
    print(message);
  });
}

Future<void> createDescriptions(Iterable<String> objects) async {
  for (var object in objects) {
    try {
      var file = File('$object.txt');
      if (await file.exists()) {
        var modified = await file.lastModified();
        print('File for $object already exists. It was modified on $modified');
        continue;
      }
      await file.create();
      await file.writeAsString('Start describing $object in this file.');
    } on IOException catch (e) {
      print('Cannot create description for $object: $e');
    }
  }
}
