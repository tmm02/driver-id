
class RedeemModel{
  String reward_id;
  String terminal_name;
  String terminal_code;
  String reward_name;
  String reward_unit;
  dynamic reward_qty;
  dynamic price_per_unit;
  String reward_status;
  String merchant_id;
  dynamic compensation_header_id;
  dynamic qty_point;


  RedeemModel({
    this.reward_id,
    this.terminal_name,
    this.terminal_code,
    this.reward_name,
    this.reward_unit,
    this.reward_qty,
    this.price_per_unit,
    this.reward_status,
    this.merchant_id,
    this.compensation_header_id,
    this.qty_point,
  });


  void copyValue(RedeemModel from){
    this.reward_id = from.reward_id;
    this.terminal_name = from.terminal_name;
    this.terminal_code = from.terminal_code;
    this.reward_name = from.reward_name;
    this.reward_unit = from.reward_unit;
    this.reward_qty = from.reward_qty;
    this.price_per_unit = from.price_per_unit;
    this.reward_status = from.reward_status;
    this.merchant_id = from.merchant_id;
    this.compensation_header_id = from.compensation_header_id;
  }

  Map<String, dynamic> toJson() => {
    'reward_id': reward_id,
    'terminal_name': terminal_name,
    'terminal_code': terminal_code,
    'reward_name': reward_name,
    'reward_unit': reward_unit,
    'reward_qty': reward_qty,
    'price_per_unit': price_per_unit,
    'reward_status': reward_status,
    'merchant_id': merchant_id,
    'compensation_header_id': compensation_header_id,
    'qty_point': qty_point,
  };

  factory RedeemModel.fromJson(Map<String, dynamic> json) => RedeemModel(
    reward_id: '${json['reward_id']}',
    terminal_name: json['terminal_name'],
    terminal_code: json['terminal_code'],
    reward_name: json['reward_name'],
    reward_unit: json['reward_unit'],
    reward_qty: json['reward_qty'],
    price_per_unit: json['price_per_unit'],
    reward_status: json['reward_status'],
    merchant_id: json['merchant_id'],
    compensation_header_id: json['compensation_header_id'],
    qty_point: json['qty_point'],
  );





}

