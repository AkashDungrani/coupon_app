
import 'package:flutter/material.dart';

import 'coupon_model.dart';

class Globals {
  static List<Coupon> couponsData = [
    Coupon(name: "10% Off", quantity: 5),
    Coupon(name: "20% Off", quantity: 4),
    Coupon(name: "30% Off", quantity: 3),
    Coupon(name: "40% Off", quantity: 2),
    Coupon(name: "50% Off", quantity: 1),
  ];

  static snackBar(
      {required BuildContext context,
      required String message,
      required Color color,
      required IconData icon}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              message,
            ),
          ],
        ),
      ),
    );
  }
}
