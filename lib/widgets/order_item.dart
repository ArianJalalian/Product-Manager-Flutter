import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as od;

class OrderItem extends StatefulWidget {
  final od.OrderItem order;
  OrderItem({this.order});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.total.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat('dd/mm/yyyy  hh:mm').format(widget.order.date),
            ),
            trailing: IconButton(
              icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Container(
              height: min(widget.order.products.length * 20.0 + 10, 100),
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                children: widget.order.products.map(
                  (pr) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          pr.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${pr.quantitiy} x \$${pr.price}',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
