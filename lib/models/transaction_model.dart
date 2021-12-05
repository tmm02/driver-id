
class TransactionModel{
  String transaction_id;
  String no_booking;
  String tid;
  String start_date;
  String in_date;
  String out_date;
  String driver_id;
  String terminal_name;
  String terminal_code;
  dynamic terminal_id;
  String point;
  int trt_achievement;
  dynamic total_trt;
  String status;


  TransactionModel({
    this.transaction_id,
    this.no_booking,
    this.tid,
    this.start_date,
    this.in_date,
    this.out_date,
    this.driver_id,
    this.terminal_name,
    this.terminal_code,
    this.terminal_id,
    this.point,
    this.trt_achievement,
    this.status,
    this.total_trt,
  });

  void copyValue(TransactionModel from){
    this.transaction_id = from.transaction_id;
    this.no_booking = from.no_booking;
    this.tid = from.tid;
    this.start_date = from.start_date;
    this.in_date = from.in_date;
    this.out_date = from.out_date;
    this.driver_id = from.driver_id;
    this.terminal_name = from.terminal_name;
    this.terminal_code = from.terminal_code;
    this.terminal_id = from.terminal_id;
    this.point = from.point;
    this.trt_achievement = from.trt_achievement;
    this.total_trt = from.total_trt;
  }

  Map<String, dynamic> toJson() => {
    'transaction_id': transaction_id,
    'no_booking': no_booking,
    'tid': tid,
    'start_date': start_date,
    'in_date': in_date,
    'out_date': out_date,
    'driver_id': driver_id,
    'terminal_name': terminal_name,
    'terminal_code': terminal_code,
    'terminal_id': terminal_id,
    'point': point,
  };

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    transaction_id: '${json['transaction_id']}',
    no_booking: json['no_booking'],
    tid: json['tid'],
    start_date: json['start_date'],
    in_date: json['in_date'],
    out_date: json['out_date'],
    driver_id: json['driver_id'],
    terminal_name: json['terminal_name'],
    terminal_code: json['terminal_code'],
    terminal_id: json['terminal_id'],
    point: json['point'],
    trt_achievement:json['trt_achievement'],
    status: json['status'],
    total_trt:json['total_trt'],
  );





}

