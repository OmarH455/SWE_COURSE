import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/core/models/order_model.dart';

void main() {
  group('OrderModel Tests', () {
    test('fromMap should create a valid OrderModel', () {
      final map = {
        'service': 'Plumbing',
        'price': 150.0,
        'status': 'Pending',
        'date': '2023-10-27T10:00:00.000',
        'time': '10:00',
        'providerName': 'Ahmed',
        'notes': 'Fix leaking pipe'
      };
      final id = 'test_order_id';

      final order = OrderModel.fromMap(id, map);

      expect(order.id, id);
      expect(order.service, 'Plumbing');
      expect(order.price, 150.0);
      expect(order.status, 'Pending');
      expect(order.bookingTime, '10:00');
      expect(order.providerName, 'Ahmed');
      expect(order.notes, 'Fix leaking pipe');
    });

    test('toMap should return a valid map', () {
      final date = DateTime.now();
      final order = OrderModel(
        id: '1',
        service: 'AC Repair',
        price: 300.0,
        status: 'Done',
        bookingDate: date,
        bookingTime: '14:00',
        providerName: 'Sami',
      );

      final map = order.toMap();

      expect(map['service'], 'AC Repair');
      expect(map['price'], 300.0);
      expect(map['status'], 'Done');
      expect(map['providerName'], 'Sami');
      expect(map['timestamp'], date.millisecondsSinceEpoch);
    });
  });
}
