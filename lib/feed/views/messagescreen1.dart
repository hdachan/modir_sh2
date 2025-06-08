import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';
import '../../widget/write_widget.dart';
import '../viewmodels/messageViewModel.dart';
import 'screen2.dart';

class Test1 extends StatefulWidget {
  final String? title;
  final String? content;
  final Uint8List? imageBytes;

  const Test1({
    super.key,
    this.title,
    this.content,
    this.imageBytes,
  });

  @override
  State<Test1> createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  @override
  void initState() {
    super.initState();
    // 화면 진입 시 ViewModel 초기화
    Provider.of<Test1ViewModel>(context, listen: false).clear();
  }

  Future<void> _showEditDialog({
    required String initialText,
    required ValueChanged<String> onConfirm,
  }) async {
    final controller = TextEditingController(text: initialText);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFE9EFF0),
        title: const Text('내용 수정'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
          TextButton(
            onPressed: () {
              onConfirm(controller.text);
              Navigator.pop(context);
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<Test1ViewModel>(context);

    return Scaffold(
      body: Column(
        children: [
          writeTopBar(),
          buildTopDivider(),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    buildAddBox(
                      label: '환영 메시지',
                      count: viewModel.welcomeItems.length,
                      max: Test1ViewModel.maxWelcome,
                      onAdd: () {
                        viewModel.addWelcomeMessage('안녕하세요');
                      },
                    ),
                    for (int i = 0; i < viewModel.welcomeItems.length; i++)
                      buildEditableBox(
                        text: viewModel.welcomeItems[i],
                        onEdit: () => _showEditDialog(
                          initialText: viewModel.welcomeItems[i],
                          onConfirm: (newText) => viewModel.updateWelcomeMessage(i, newText),
                        ),
                        onDelete: () => viewModel.deleteWelcomeMessage(i),
                      ),
                    buildAddBox(
                      label: '카테고리 추가',
                      count: viewModel.categoryItems.length,
                      max: Test1ViewModel.maxCategory,
                      onAdd: () {
                        viewModel.addCategory('카테고리 ${viewModel.categoryItems.length + 1}');
                      },
                    ),
                    for (int i = 0; i < viewModel.categoryItems.length; i++)
                      buildEditableBox(
                        text: viewModel.categoryItems[i],
                        onEdit: () => _showEditDialog(
                          initialText: viewModel.categoryItems[i],
                          onConfirm: (newText) => viewModel.updateCategory(i, newText),
                        ),
                        onDelete: () => viewModel.deleteCategory(i),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFFFFFFF),
    );
  }

  PreferredSizeWidget writeTopBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 14),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.black, size: 24),
                  ),
                  const Spacer(),
                  const Text(
                    "모디챗 설정1",
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      final viewModel = Provider.of<Test1ViewModel>(context, listen: false);

                      if (viewModel.welcomeItems.isEmpty || viewModel.categoryItems.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('환영 메시지와 카테고리를 모두 하나 이상 입력해주세요.'),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Screen2(
                            title: widget.title,
                            content: widget.content,
                            imageBytes: widget.imageBytes,
                            categoryItems: viewModel.categoryItems,
                            welcomeItems: viewModel.welcomeItems,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "다음",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}