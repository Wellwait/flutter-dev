import 'package:flutter/material.dart';

class BookingScreenMiddle2 extends StatelessWidget {
  final List<PanelItem> panels = [
    PanelItem(name: 'Panel 2', queue: '02'),
    PanelItem(name: 'Panel 3', queue: '03'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top service added button or message
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          color: Colors.teal,
          alignment: Alignment.center,
          child: Text(
            '1 service added',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),

        // Panels list
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: panels.length,
            itemBuilder: (context, index) {
              return PanelTile(panel: panels[index]);
            },
          ),
        ),
      ],
    );
  }
}

class PanelItem {
  final String name;
  final String queue;

  PanelItem({required this.name, required this.queue});
}

class PanelTile extends StatelessWidget {
  final PanelItem panel;
  PanelTile({required this.panel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE6F7F7), // Light blue background
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(panel.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text('Queue - ${panel.queue}',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
