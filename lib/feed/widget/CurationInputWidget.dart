// import 'package:flutter/material.dart';
// import 'dart:typed_data';
//
// class CurationInputWidget extends StatefulWidget {
//   final String title;
//   final String itemName;
//   final TextEditingController contentController;
//   final List<Uint8List> images;
//   final VoidCallback onImagePick;
//   final VoidCallback onComplete;
//   final Color buttonColor;
//
//   const CurationInputWidget({
//     Key? key,
//     required this.title,
//     required this.itemName,
//     required this.contentController,
//     required this.images,
//     required this.onImagePick,
//     required this.onComplete,
//     required this.buttonColor,
//   }) : super(key: key);
//
//   @override
//   State<CurationInputWidget> createState() => _CurationInputWidgetState();
// }
//
// class _CurationInputWidgetState extends State<CurationInputWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       body: _buildBody(),
//       bottomNavigationBar: _buildBottomBar(),
//       backgroundColor: Colors.white,
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar() {
//     return PreferredSize(
//       preferredSize: const Size.fromHeight(56),
//       child: Container(
//         color: Colors.white,
//         child: Center(
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(maxWidth: 600),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1C1B1F), size: 24),
//                   onPressed: () {
//                     if (widget.contentController.text.trim().isEmpty) {
//                       showDialog(
//                         context: context,
//                         builder: (context) => Dialog(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                           backgroundColor: const Color(0xFFF0F0F0),
//                           child: ConstrainedBox(
//                             constraints: const BoxConstraints(maxWidth: 280),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
//                                   child: Text(
//                                     '아직 큐레이션의 내용을 입력하지 않았어요 큐레이션 작성을 취소하시겠어요?',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF000000)),
//                                   ),
//                                 ),
//                                 const Divider(color: Color(0xFFE0E0E0), thickness: 1, height: 1),
//                                 SizedBox(
//                                   height: 44,
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         child: TextButton(
//                                           onPressed: () => Navigator.of(context).pop(),
//                                           child: const Text('닫기', style: TextStyle(color: Color(0xFF3D3D3D), fontSize: 14)),
//                                         ),
//                                       ),
//                                       Container(width: 1, color: Color(0xFFE0E0E0)),
//                                       Expanded(
//                                         child: TextButton(
//                                           onPressed: () {
//                                             Navigator.of(context).pop();
//                                             Navigator.of(context).pop();
//                                           },
//                                           child: const Text('확인', style: TextStyle(color: Color(0xFF3D3D3D), fontSize: 14)),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     } else {
//                       Navigator.pop(context);
//                     }
//                   },
//                 ),
//                 Expanded(
//                   child: Center(
//                     child: Text(
//                       widget.title,
//                       style: const TextStyle(
//                         color: Color(0xFF000000),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8),
//                   child: GestureDetector(
//                     onTap: widget.onComplete,
//                     child: Container(
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.transparent,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         '완료',
//                         style: TextStyle(
//                           color: widget.buttonColor,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBody() {
//     return Center(
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 600),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Divider(color: Color(0xE7E7E7), thickness: 5, height: 0.5),
//                     _buildBlackBox('큐레이션 리스트'),
//                     const Divider(color: Color(0xE7E7E7), thickness: 0.1, height: 0.1),
//                     _buildGreyBox(widget.itemName),
//                     const Divider(color: Color(0xE7E7E7), thickness: 0.1, height: 0.1),
//                     _buildBlackBox('답변'),
//                     const Divider(color: Color(0xE7E7E7), thickness: 0.1, height: 0.1),
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//                       child: TextField(
//                         controller: widget.contentController,
//                         maxLines: null,
//                         minLines: 10,
//                         textAlignVertical: TextAlignVertical.top,
//                         decoration: const InputDecoration(
//                           hintText: '내용을 입력해주세요',
//                           hintStyle: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xFF888888),
//                           ),
//                           border: InputBorder.none,
//                           enabledBorder: InputBorder.none,
//                           focusedBorder: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16),
//               child: SizedBox(
//                 height: 140,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       const SizedBox(width: 16),
//                       ...widget.images.map((image) => Padding(
//                         padding: const EdgeInsets.only(right: 8),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.memory(image, width: 160, height: 200, fit: BoxFit.cover),
//                         ),
//                       )),
//                       const SizedBox(width: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             const Divider(
//               color: Color(0xE7E7E7),
//               thickness: 1,
//               height: 1,
//               indent: 0,
//               endIndent: 0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBottomBar() {
//     return ConstrainedBox(
//       constraints: const BoxConstraints(maxWidth: 600),
//       child: Container(
//         height: 56,
//         color: const Color(0xFFFFFFFF),
//         padding: const EdgeInsets.all(8),
//         child: Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8),
//               child: GestureDetector(
//                 onTap: widget.onImagePick,
//                 child: const Icon(
//                   Icons.broken_image_outlined,
//                   color: Color(0xFF3D3D3D),
//                   size: 28,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Padding(
//               padding: const EdgeInsets.all(8),
//               child: GestureDetector(
//                 onTap: widget.onImagePick,
//                 child: const Icon(
//                   Icons.camera_alt_outlined,
//                   color: Color(0xFF3D3D3D),
//                   size: 28,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildGreyBox(String label) => Padding(
//     padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
//     child: Text(
//       label,
//       style: const TextStyle(
//         fontSize: 12,
//         fontWeight: FontWeight.w500,
//         color: Color(0xFF000000),
//       ),
//     ),
//   );
//
//   Widget _buildBlackBox(String label) => Padding(
//     padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
//     child: Text(
//       label,
//       style: const TextStyle(
//         fontSize: 12,
//         fontWeight: FontWeight.w700,
//         color: Color(0xFF000000),
//       ),
//     ),
//   );
// }