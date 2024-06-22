import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mismatchh/constants/colors.dart';
import 'package:mismatchh/constants/miscellaneous.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.name, required this.profileImg});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
  final String name;
  final String profileImg;

}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kYellow,
      title: _buildTitle(),
      leading: _buildBackButton(),
      titleSpacing: 0,
      actions: [_buildActions()],
    );
  }

  Widget _buildTitle() {
    return Row(mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: CachedNetworkImageProvider(widget.profileImg),
        ),
        const SizedBox(width: 10,),
        Text(widget.name)
      ],
    );
  }
  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 20,
      ),
    );
  }

  Widget _buildActions() {
    return const Padding(
      padding: EdgeInsets.only( right: 10),
      child: Icon(Icons.more_vert_rounded, color: kBlack),
    );
  }
}
