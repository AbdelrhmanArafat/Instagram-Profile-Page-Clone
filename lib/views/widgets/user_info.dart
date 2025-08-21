import 'package:flutter/material.dart';
import 'package:instagram_clone/views/widgets/custom_text.dart';

class UserInfo extends StatelessWidget {
  final String userImage;
  final String postsNumbers;
  final String followersNumbers;
  final String followingNumbers;

  const UserInfo({
    super.key,
    required this.userImage,
    required this.postsNumbers,
    required this.followersNumbers,
    required this.followingNumbers,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Colors.pinkAccent,
                Colors.pinkAccent,
                Colors.orangeAccent,
              ],
            ),
          ),
          child: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(userImage),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: postsNumbers,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            CustomText(text: 'Posts'),
          ],
        ),
        SizedBox(width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: followersNumbers,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            CustomText(text: 'Followers'),
          ],
        ),
        SizedBox(width: 30),
        Column(
          children: [
            CustomText(
              text: followingNumbers,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            CustomText(text: 'Following'),
          ],
        ),
      ],
    );
  }
}
