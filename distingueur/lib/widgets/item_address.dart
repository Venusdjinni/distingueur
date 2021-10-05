import 'package:distingueur/models/persistence.dart';
import 'package:flutter/material.dart';

class AddressItem extends StatelessWidget {
  final Address address;

  const AddressItem({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.tag,
          color: Colors.white,
        ),
      ),
      title: Text(address.site),
      subtitle: Text("${address.as}:${address.rd}"),
    );
  }
}
