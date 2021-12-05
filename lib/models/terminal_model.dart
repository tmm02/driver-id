
class TerminalModel{
  int terminal_id;
  String terminal_name;
  String terminal_code;

  //dropdown option purpose
  // String id;
  // String name;

  TerminalModel({
    this.terminal_id,
    this.terminal_name,
    this.terminal_code,
    // this.id,
    // this.name,

  });

  void copyValue(TerminalModel from){
    this.terminal_id = from.terminal_id;
    this.terminal_name = from.terminal_name;
    this.terminal_code = from.terminal_code;
    // this.id = from.id;
    // this.name = from.name;
  }

  Map<String, dynamic> toJson() => {
    'terminal_id': terminal_id,
    'terminal_name': terminal_name,
    'terminal_code': terminal_code,
    // 'id': id,
    // 'name': name,
  };

  factory TerminalModel.fromJson(Map<String, dynamic> json) => TerminalModel(
    terminal_name: json['terminal_name'],
    terminal_id: json['terminal_id'],
    terminal_code: json['terminal_code'],
    // id: '${json['id']}',
    // name: json['terminal_name'],
  );

  factory TerminalModel.fromBookmarksListJson(Map<String, dynamic> json) => TerminalModel(
    terminal_name: json['terminal_name'],
    terminal_id: json['terminal_id'],
    terminal_code: json['terminal_code'],
    // id: json['id'],
    // name: json['terminal_name'],
  );

  factory TerminalModel.fromHiddenListJson(Map<String, dynamic> json) => TerminalModel(
    terminal_name: json['terminal_name'],
    terminal_id: json['terminal_id'],
    terminal_code: json['terminal_code'],
    // id: json['id'],
    // name: json['terminal_name'],
  );



}

