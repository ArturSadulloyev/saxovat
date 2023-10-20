import 'package:flutter/material.dart';
import '../../pages/donation_page.dart';

class CategorySelectBtn extends StatelessWidget {
  const CategorySelectBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            FloatingActionButton(
              heroTag: UniqueKey(),
              backgroundColor: Colors.green.shade50,
              elevation: 0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DonationPage(
                        // list: charityList2,
                        // category: 'Volontyorlik',
                        ),
                  ),
                );
              },
              child: const Image(
                height: 40,
                width: 40,
                image: AssetImage('assets/images/PngItem_733744.png'),
              ),
            ),
            const Text('Volontyorlik'),
          ],
        ),
        const SizedBox(width: 20),
        Column(
          children: [
            FloatingActionButton(
              heroTag: UniqueKey(),
              backgroundColor: Colors.blue.shade50,
              elevation: 0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DonationPage(
                        // list: donationList,
                        // category: 'Xayriya',
                        ),
                  ),
                );
              },
              child: const Image(
                height: 40,
                width: 40,
                image: AssetImage('assets/images/pngegg.png'),
              ),
            ),
            const Text('Xayriya'),
          ],
        ),
      ],
    );
  }
}
