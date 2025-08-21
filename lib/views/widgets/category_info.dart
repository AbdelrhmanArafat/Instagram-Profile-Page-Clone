import 'package:flutter/material.dart';
import 'package:instagram_clone/views/widgets/custom_text.dart';

class CategoryInfo extends StatelessWidget {
  final List image;
  final String category;

  const CategoryInfo({super.key, required this.image, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: category, fontColor: Colors.blue.shade200),
        const SizedBox(height: 5),
        Row(
          children: [
            Transform.rotate(angle: -10, child: Icon(Icons.link)),
            const SizedBox(width: 10),
            CustomText(
              text: "https://jednvrnvirnv.com",
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            SizedBox(
              height: 40,
              width: (image.length * 27) + 18,
              child: Stack(
                children: [
                  for (int i = 0; i < image.length; i++)
                  Positioned(
                    left: i * 25,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(image[i]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 310,
              child: CustomText(
                text: "Followed by vot444, a_ejfneef , frfrf and messi",
                fontWeight: FontWeight.bold,
                fontSize: 13,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
