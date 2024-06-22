import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mismatchh/constants/miscellaneous.dart';
import 'package:mismatchh/constants/strings.dart';
import 'package:mismatchh/constants/textstyles.dart';

class ChatTile extends StatelessWidget {
  const ChatTile(
      {super.key,
      required this.profileImg,
      required this.name,
      required this.lastMessage,
      required this.time,
      required this.onTap});

  final String profileImg;
  final String name;
  final String lastMessage;
  final String time;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(
                      imageUrl: profileImg,
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                      fadeInCurve: Curves.easeIn,
                      fadeOutCurve: Curves.easeOut,
                      fadeInDuration: kAnimationDuration,
                      fadeOutDuration: kAnimationDuration,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: text16SemiBold,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          lastMessage,
                          style: text14Regular,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '$time\t$ago',
              style: text14Medium,
            ),
          ],
        ),
      ),
    );
  }
}
