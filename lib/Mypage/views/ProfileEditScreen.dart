import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../widget/login_widget.dart';
import '../viewmodels/ProfileViewModel.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Consumer 외부에서 viewModel 가져오기
    final viewModel = Provider.of<ProfileViewModel>(context, listen: false);

    // 화면 진입 시 사용자 정보 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchUserInfo();
    });

    return Consumer<ProfileViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: emailAppBar(
            context,
            "내 정보 수정",
            const Color(0xFF000000),
                () => print('완료 버튼 눌림'),
          ),
          body: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(scrollbars: false),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              clipBehavior: Clip.none,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildLabel("닉네임"),
                        buildInput(viewModel.nicknameController, "모디랑"),
                        const SizedBox(height: 8),
                        const Text(
                          '닉네임은 한영문자 포함 특수문자 _만 사용가능합니다',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Pretendard',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 32),
                        buildLabel("생년월일"),
                        buildInput(
                            viewModel.birthdateController, "20000101",
                            isNumber: true),
                        const SizedBox(height: 32),
                        buildLabel("성별"),
                        Row(
                          children: [
                            GenderButton(
                              label: '남자',
                              isSelected: viewModel.selectedGenderIndex == 0,
                              onTap: () => viewModel.onGenderButtonPressed(0),
                            ),
                            const SizedBox(width: 16),
                            GenderButton(
                              label: '여자',
                              isSelected: viewModel.selectedGenderIndex == 1,
                              onTap: () => viewModel.onGenderButtonPressed(1),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        buildLabel("소개글"),
                        buildInput(
                            viewModel.categoryController, "소개글을 입력하세요"),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: bottomBar(() async {
            await viewModel.updateUserInfo();
            if (viewModel.errorMessage == null) {
              context.go("/mypage");
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(viewModel.errorMessage!)),
              );
            }
          }),
          backgroundColor: Colors.white,
        );
      },
    );
  }

  static Widget buildLabel(String text) => Text(
    text,
    style: const TextStyle(
      color: Colors.black,
      fontFamily: 'Pretendard',
      fontSize: 14,
      fontWeight: FontWeight.w700,
      height: 1.4,
      letterSpacing: -0.35,
    ),
  );

  static Widget buildInput(TextEditingController controller, String hintText,
      {bool isNumber = false}) {
    return Container(
      height: 56,
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: const TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Pretendard',
            color: Color(0xFF888888),
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }

  Widget bottomBar(VoidCallback onPressed) {
    return Container(
      height: 68,
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onPressed,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3D3D3D),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "완료",
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GenderButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 48,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3D3D3D)
                    : const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF3D3D3D)
                      : const Color(0xFFCCCCCC),
                  width: 1,
                ),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}