import 'package:flutter/material.dart';
import 'package:mismatchh/constants/colors.dart';
import 'package:mismatchh/presentation/provider/dashboard/chat_provider.dart';
import 'package:mismatchh/presentation/views/dashboard/chat_screen.dart';
import 'package:mismatchh/presentation/widgets/dashboard/chat_tile.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getChatList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildChatList();
  }

  Widget _buildChatList() {
    return Consumer<ChatProvider>(
      builder: (BuildContext context, provider, Widget? child) {
        return SafeArea(
          child: RefreshIndicator(
            color: kYellow,
            onRefresh: () async {
              provider.chatList.clear();
              await getChatList();
            },
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: provider.chatList.length,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              physics: const ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                String profileImg =
                    provider.chatList[index].imageUrl.toString();
                String name = provider.chatList[index].name.toString();
                String lastMessage =
                    provider.chatList[index].lastMessage.toString();
                String time = provider.chatList[index].time.toString();
                return Column(
                  children: [
                    if (index != 0)
                      Divider(
                        color: kGrey.withOpacity(0.5),
                        height: 1,
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: _buildChatTile(
                          profileImg, name, lastMessage, time, index),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatTile(String profileImg, String name, String lastMessage,
      String time, int index) {
    return ChatTile(
      profileImg: profileImg,
      name: name,
      lastMessage: lastMessage,
      time: time,
      onTap: () {
        onTap(name, profileImg);
      },
    );
  }

  onTap(String name, String profileImg) {
    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> ChatScreen(name: name, profileImg: profileImg,)));
  }

  /// API Calls ---------------------------------------------
  Future getChatList() async {
    var provider = Provider.of<ChatProvider>(context, listen: false);
    await provider.getChatList();
  }
}
