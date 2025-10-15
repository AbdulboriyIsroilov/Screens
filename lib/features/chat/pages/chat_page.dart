import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/utils/app_svg.dart';
import '../managers/chat_bloc.dart';
import '../managers/chat_state.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat_message_list.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();
  final scrollController = ScrollController();
  bool isScrolling = false;

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (!scrollController.hasClients) return;
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    MyLocalizations local = MyLocalizations.of(context)!;
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarCommon(
            title: local.customer_service,
            activ: 4,
            actionSvg: AppSvgs.phone,
            onPressed: () => context.pop(),
          ),

          body: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.direction == ScrollDirection.idle) {
                if (isScrolling) setState(() => isScrolling = false);
              } else {
                if (!isScrolling) setState(() => isScrolling = true);
              }
              return false;
            },
            child: ChatMessageList(
              messages: state.messages,
              scrollController: scrollController,
            ),
          ),

          bottomNavigationBar: ChatInputBar(
            controller: controller,
            theme: theme,
            isScrolling: isScrolling,
            onSend: (text) {
              context.read<ChatBloc>().add(ChatMessageSend(message: text));
              _scrollToBottom();
            },
          ),
        );
      },
    );
  }
}
