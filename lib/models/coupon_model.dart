class Coupon {
  final String name;
  final int quantity;

  Coupon({required this.name, required this.quantity});

  factory Coupon.data({required Coupon data}) {
    return Coupon(name: data.name, quantity: data.quantity);
  }
}

class CouponDB {
  final String name;
  final int quantity;

  CouponDB({required this.name, required this.quantity});

  factory CouponDB.data({required Map data}) {
    return CouponDB(name: data["coupon"], quantity: data["Quantity"]);
  }
}
