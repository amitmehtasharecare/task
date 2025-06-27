import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poketest/model/user_model.dart';

class DetailPage extends GetView {
  const DetailPage({super.key, required this.user});
  final Data user;

  @override
  Widget build(BuildContext context) {
    double widthSize = resWidthSize(context);
    double heightSize = resHeightSize(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(user.name!),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: widthSize * 2, vertical: heightSize * 2),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: (user.images?.large != null &&
                          user.images!.large!.startsWith('data:'))
                      ? Container(height: 200, color: Colors.grey)
                      : Image.network(
                          user.images!.large!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(
                height: heightSize * 2,
              ),
              Text(
                '${user.name}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: heightSize * 0.5),
              Text(
                'HP: ${user.hp}',
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: heightSize * 0.5),
              Text(
                'Supertype: ${user.supertype}',
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: heightSize * 0.5),
              Text(
                user.subtypes != null && user.subtypes!.isNotEmpty
                    ? 'Subtypes : ${user.subtypes!.first}'
                    : '',
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: heightSize * 2),
              Text(
                'Set : ${user.set?.name}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: heightSize * 0.5),
              (user.set?.images?.symbol != null &&
                      user.set!.images!.symbol!.startsWith('data:'))
                  ? Container(height: 50, width: 60, color: Colors.grey)
                  : Image.network(
                      user.set!.images!.symbol!,
                      height: 50,
                      width: 60,
                    ),
              SizedBox(height: heightSize * 2),
              Text(
                'Series : ${user.set?.series}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: heightSize * 0.5),
              if (user.attacks != null && user.attacks!.isNotEmpty) ...[
                SizedBox(height: heightSize * 2),
                const Text(
                  'Attacks:',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: heightSize),
                ...user.attacks!.map((attack) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: heightSize),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• ${attack.name ?? 'Unknown'}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (attack.cost != null && attack.cost!.isNotEmpty)
                          Text(
                            'Cost: ${attack.cost!.join(', ')}',
                            style: const TextStyle(fontWeight: FontWeight.w300),
                          ),
                        if (attack.damage != null && attack.damage!.isNotEmpty)
                          Text(
                            'Damage: ${attack.damage}',
                            style: const TextStyle(fontWeight: FontWeight.w300),
                          ),
                        if (attack.text != null && attack.text!.isNotEmpty)
                          Text(
                            'Effect: ${attack.text}',
                            style: const TextStyle(fontWeight: FontWeight.w300),
                          ),
                        SizedBox(height: heightSize),
                      ],
                    ),
                  );
                }).toList(),
              ]
            ],
          ),
        ),
      ),
    );
  }

  double resWidthSize(BuildContext context) {
    // device width & height size parameter
    double widthSize;
    if (MediaQuery.of(context).size.width > 598) {
      widthSize = MediaQuery.of(context).size.width * 0.0072;
    } else {
      widthSize = MediaQuery.of(context).size.width * 0.01;
    }
    return widthSize;
  }

  double resHeightSize(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height * 0.01;
    return heightSize;
  }
}
