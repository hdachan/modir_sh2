// 돟의하기 화면 상단바
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget CustomAppBar({required String title, required BuildContext context}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        titleSpacing: 0,
        title: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF000000),
                        size: 24,
                      ),
                    ),
                  ),
                ),
                Text(
                  title, // <-- 여기만 바꿨어요!
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 1.40,
                    letterSpacing: -0.35,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

//환경설정 상단바
Widget ProfileEditAppBar({required String title, required BuildContext context}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return Container(
        width: double.infinity,
        height: 56,
        color:  Colors.white,
        padding: EdgeInsets.only(
          right: 16,
        ),
        child: Row(
          children: [
            // 뒤로가기 버튼
            GestureDetector(
              onTap: () {
                context.go('/mypage');
              },
              child: Container(
                width: 56,
                height: 56,
                padding: const EdgeInsets.all(16),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 24,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              height: 56,
              padding: const EdgeInsets.only(top: 14,bottom: 14),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  height: 1.40,
                  letterSpacing: -0.50,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}