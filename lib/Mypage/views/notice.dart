import 'package:flutter/material.dart';

class NoticeBoard extends StatefulWidget {
  const NoticeBoard({Key? key}) : super(key: key);

  @override
  State<NoticeBoard> createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  bool showDescription = false;
  int? expandedIndex;

  final List<Map<String, String>> dummyNotices = const [
    {
      'title': '앱 업데이트 안내',
      'date': '2025.06.01',
      'content': '앱이 0.0.1 버전으로 업데이트되었습니다. 새로운 기능과 버그 수정이 포함되어 있습니다.'
    },
    {
      'title': '베타테스트 안내',
      'date': '2025.03.10',
      'content': '3월 10일~ @ 까지 베타테스트 중임을 알립니다. '
    },
    {
      'title': '신규 기능 출시',
      'date': '2025.06.06',
      'content': '새로운 마이큐레이션 기능이 추가되었습니다. 이제 나만의 공간을 꾸며보세요.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상단바
                Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).maybePop(),
                          child: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showDescription = !showDescription;
                          });
                        },
                        child: const Text(
                          '공지사항',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Pretendard',
                            letterSpacing: -0.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 설명
                if (showDescription)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      '앱 이용에 필요한 중요한 소식들을 모아둔 공간이에요. 점검 일정, 업데이트 안내 등을 확인하실 수 있어요.',
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 13,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                  ),

                // 리스트
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: dummyNotices.length,
                    separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFE7E7E7)),
                    itemBuilder: (context, index) {
                      final notice = dummyNotices[index];
                      final isExpanded = expandedIndex == index;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                            title: Text(
                              notice['title']!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.2,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                notice['date']!,
                                style: const TextStyle(
                                  color: Color(0xFF888888),
                                  fontSize: 12,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ),
                            trailing: Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.arrow_forward_ios,
                              size: 14,
                              color: const Color(0xFF888888),
                            ),
                            onTap: () {
                              setState(() {
                                expandedIndex = isExpanded ? null : index;
                              });
                            },
                          ),
                          if (isExpanded)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16),
                              child: Text(
                                notice['content']!,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 13,
                                  fontFamily: 'Pretendard',
                                ),
                              ),
                            ),
                        ],
                      );
                    },
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
