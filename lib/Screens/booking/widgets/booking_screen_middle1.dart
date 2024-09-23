import 'package:flutter/material.dart';

class BookingScreenMiddle1 extends StatelessWidget {
  final List<ServiceItem> services = [
    ServiceItem(
        name: 'Haircut', price: 300, imagePath: 'assets/icons/haircut1.png'),
    ServiceItem(
        name: 'Nails', price: 1000, imagePath: 'assets/icons/nails1.png'),
    ServiceItem(
        name: 'Message', price: 1500, imagePath: 'assets/icons/massage1.png'),
    ServiceItem(
        name: 'Facial', price: 500, imagePath: 'assets/icons/faicial1.png'),
    ServiceItem(
        name: 'Manicure', price: 500, imagePath: 'assets/icons/manicure.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Set the background to white
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Panels',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                return ServiceTile(service: services[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceItem {
  final String name;
  final int price;
  final String imagePath;

  ServiceItem(
      {required this.name, required this.price, required this.imagePath});
}

class ServiceTile extends StatelessWidget {
  final ServiceItem service;
  ServiceTile({required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          service.imagePath,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(service.name),
        subtitle: Text('Rs- ${service.price}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('-20%', style: TextStyle(color: Colors.orange)),
            IconButton(
              icon: Icon(Icons.add_circle_outline, color: Colors.teal),
              onPressed: () {
                // Add your logic here for adding the service
              },
            ),
          ],
        ),
      ),
    );
  }
}
