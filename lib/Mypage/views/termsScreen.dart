import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/Mypage_widget.dart';
import '../../widget/agree_widget.dart';




class termsScreen extends StatefulWidget {
  @override
  _termsScreenState createState() => _termsScreenState();
}

class _termsScreenState extends State<termsScreen> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                CustomAppBar(title: '약관', context: context),
                customButton(
                  '모디랑 이용약관',
                      () async {
                    final url = Uri.parse('https://holybaits-modir.notion.site/132a2688a39a8092bdefcea510e0fd86'); // 원하는 링크로 변경
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    } else {
                      // 오류 처리 (선택사항)
                      print('URL을 열 수 없습니다.');
                    }
                  },
                ),
                customButton(
                  '개인정보 처리 방침',
                      () async {
                    final url = Uri.parse('https://holybaits-modir.notion.site/132a2688a39a8092bdefcea510e0fd86'); // 원하는 링크로 변경
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    } else {
                      // 오류 처리 (선택사항)
                      print('URL을 열 수 없습니다.');
                    }
                  },
                ),
                // customButton(
                //   '위치기반서비스 이용약관',
                //       () {
                //   },
                // ),
                // customButton(
                //   '데이터제공정책',
                //       () {
                //   },
                // ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}