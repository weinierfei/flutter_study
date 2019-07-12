class Message {
  final String msg;
  final int timetamp;

  Message(this.msg, this.timetamp);

  Message.create(String msg)
      : msg = msg,
        timetamp = DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() => {
        'msg': "$msg",
        'timetam': "$timetamp",
      };

  Message.fromJson(Map<String, dynamic> json)
      : msg = json['msg'],
        timetamp = json['timetamp'];

  @override
  String toString() {
    return 'Message{msg: $msg, timetam: $timetamp}';
  }
}
