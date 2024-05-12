// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tanysu/core/constants/colors.dart';
// import 'package:tanysu/features/chat_page/presentation/bloc/chat_page_bloc.dart';
// import 'package:tanysu/features/message/data/models/message_model.dart';
// import 'package:tanysu/features/message/presentation/bloc/message_bloc.dart';
// import 'package:tanysu/features/message/presentation/widgets/group_message_block.dart';
// import 'package:tanysu/l10n/translate.dart';

// // ignore: depend_on_referenced_packages
// import 'package:web_socket_channel/web_socket_channel.dart';

// class PublicMessagePage extends StatefulWidget {
//   final String name;
//   final String image;
//   final int chatId;
//   final int userId;
//   const PublicMessagePage({
//     Key? key,
//     required this.name,
//     required this.image,
//     required this.chatId,
//     required this.userId,
//   }) : super(key: key);

//   @override
//   State<PublicMessagePage> createState() => _PublicMessagePageState();
// }

// class _PublicMessagePageState extends State<PublicMessagePage> {
//   late TextEditingController textController;
//   late WebSocketChannel channel;
//   late MessageBloc bloc;
//   late ChatPageBloc bloc1;
//   late List<MessageModel> messages;
//   late ScrollController _scrollController;
//   void sendMessage() {
//     channel.sink.add(
//       jsonEncode(
//         {
//           "message": textController.text,
//           "user_id": widget.userId,
//         },
//       ),
//     );
//   }

//   void deleteMessage(
//     int messageId,
//     int userId,
//   ) {
//     channel.sink.add(
//       jsonEncode(
//         {
//           'type': 'delete',
//           'message_id': messageId,
//           'user_id': userId,
//         },
//       ),
//     );
//     for (var element in messages) {
//       if ((element.id ?? 0) == messageId) {
//         messages.remove(element);
//       }
//     }
//   }

//   // void readed(int messageId) {
//   //   channel.sink.add(
//   //     jsonEncode(
//   //       {
//   //         "type": "mark_as_read",
//   //         "message_id": messageId,
//   //       },
//   //     ),
//   //   );
//   // }

//   // chatSocket.send(JSON.stringify({
//   //               'type': 'mark_as_read',
//   //               'message_id': messageId
//   //           }));

//   @override
//   void initState() {
//     messages = [];
//     _scrollController = ScrollController();
//     bloc = BlocProvider.of<MessageBloc>(context);
//     bloc1 = BlocProvider.of<ChatPageBloc>(context);
//     bloc.add(GetAllMessages(chatId: widget.chatId));
//     channel = WebSocketChannel.connect(
//       Uri.parse(
//           'wss://tanysu.net/ws/v3/chat/${widget.chatId}/${widget.userId}/'),
//     );
//     textController = TextEditingController();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         surfaceTintColor: Colors.transparent,
//         leadingWidth: 50,
//         elevation: 0,
//         leading: Row(
//           children: [
//             const SizedBox(width: 12),
//             InkWell(
//               child: SvgPicture.asset('assets/icons/back_button.svg'),
//               onTap: () {
//                 bloc1.add(GetAllChats());
//                 Navigator.pop(context);
//               },
//             ),
//             const Spacer(),
//           ],
//         ),
//         centerTitle: true,
//         title: Text(
//           widget.name,
//           style: GoogleFonts.montserrat(
//             color: Colors.black,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//           // overflow: TextOverflow.ellipsis,
//         ),
//         // actions: [
//         //   Padding(
//         //     padding: const EdgeInsets.only(right: 20),
//         //     child: GestureDetector(
//         //       onTap: () {
//         //         showBlock(context, widget.name, widget.userId);
//         //       },
//         //       child: SvgPicture.asset(
//         //         'assets/icons/info.svg',
//         //         height: 24,
//         //         width: 24,
//         //       ),
//         //     ),
//         //   ),
//         // ],
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(1.0),
//           child: Container(
//             height: 1,
//             width: double.infinity,
//             color: Colors.black12,
//           ),
//         ),
//       ),
//       body: Scaffold(
//         body: SafeArea(
//           child: Stack(
//             children: [
//               SvgPicture.asset(
//                 'assets/background/message_background_pattern.svg',
//                 fit: BoxFit.cover,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: BlocBuilder<MessageBloc, MessageState>(
//                         builder: (context, state) {
//                           if (state is MessageGot) {
//                             messages = state.messages;
//                             return StreamBuilder(
//                               stream: channel.stream,
//                               builder: (context, snapshot) {
//                                 if (snapshot.hasData) {
//                                   Map<String, dynamic> info =
//                                       jsonDecode(snapshot.data);
//                                   debugPrint(info.toString());
//                                   if (info['message'] !=
//                                       'You are now connected!') {
//                                     messages.add(
//                                       MessageModel(
//                                         chat: widget.chatId,
//                                         content: info['message'],
//                                         sender: info['user'],
//                                         timestamp: info['timestamp'],
//                                         is_svg: null,
//                                         is_read: false,
//                                         id: null,
//                                         name: info['name'],
//                                         photo: info['photo'],
//                                         profile_id: info['profile_id'],
//                                       ),
//                                     );
//                                   }
//                                 }
//                                 return GroupMessageBlock(
//                                   userId: widget.userId,
//                                   messages: messages,
//                                   deleteMessageFunction: deleteMessage,
//                                   scrollController: _scrollController,
//                                 );
//                               },
//                             );
//                           } else if (state is MessageGetting) {
//                             return Center(
//                               child: Platform.isAndroid
//                                   ? CircularProgressIndicator(
//                                       color: secondColor,
//                                       strokeWidth: 3,
//                                     )
//                                   : CupertinoActivityIndicator(
//                                       color: secondColor,
//                                     ),
//                             );
//                           } else {
//                             return Center(
//                               child: Text(translation(context).chat_get_error),
//                             );
//                           }
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       height: 42,
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: TextField(
//                               cursorHeight: 18,
//                               style: GoogleFonts.montserrat(
//                                 color: Colors.black,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               // textAlignVertical: TextAlignVertical.center,
//                               textAlign: TextAlign.left,
//                               maxLines: 1,
//                               controller: textController,
//                               decoration: InputDecoration(
//                                 isDense: true,
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 12,
//                                   vertical: 10,
//                                 ),
//                                 fillColor: Colors.white,
//                                 hintText: translation(context).message,
//                                 hintStyle: GoogleFonts.montserrat(
//                                   color: Colors.black54,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                     color: mainColor20,
//                                     width: 1,
//                                   ),
//                                 ),
//                                 filled: true,
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                     color: mainColor20,
//                                     width: 1,
//                                   ),
//                                 ),
//                                 disabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                     color: mainColor20,
//                                   ),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                     color: mainColor50,
//                                   ),
//                                 ),
//                               ),
//                               onSubmitted: (value) {
//                                 sendMessage();
//                               },
//                             ),
//                           ),
//                           const SizedBox(width: 4),
//                           GestureDetector(
//                             child: Container(
//                               height: 44,
//                               width: 44,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(12),
//                                 border: Border.all(
//                                   width: 1,
//                                   color: mainColor20,
//                                 ),
//                               ),
//                               child: Center(
//                                 child: SvgPicture.asset(
//                                   'assets/icons/send_black.svg',
//                                 ),
//                               ),
//                             ),
//                             onTap: () {
//                               sendMessage();
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     bloc.add(Reset());
//     channel.sink.close();
//     textController.dispose();
//     super.dispose();
//   }
// }
