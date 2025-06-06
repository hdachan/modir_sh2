import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart'; // 날짜 포맷팅을 위해 추가
import 'CurationCard.dart';
import 'CurationLogCarousel.dart';
import 'ViewModel/Test6ViewModel.dart';
import 'curationwidget.dart';

bool isExpanded = false;

class Test6 extends StatefulWidget {
  const Test6({super.key});

  @override
  State<Test6> createState() => _Test6State();
}

class _Test6State extends State<Test6> {
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    final userId = Supabase.instance.client.auth.currentUser?.id ?? 'example-uuid';
    print('Current userId: $userId');
    context.read<Test6ViewModel>().fetchUserData(userId).then((_) {
      // 강제로 UI 갱신
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Test6ViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: curationcustomAppBar(context, "마이 큐레이션"),
          body: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : viewModel.errorMessage != null
              ? Center(child: Text(viewModel.errorMessage!))
              : SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 202,
                            padding: const EdgeInsets.only(
                                top: 8, left: 16, right: 16, bottom: 8),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/image/bgimage.jpg'),
                                fit: BoxFit.fitWidth,
                                colorFilter: ColorFilter.mode(
                                  Color(0x66000000),
                                  BlendMode.srcOver,
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 16,
                            bottom: -18,
                            child: SizedBox(
                              height: 80,
                              width: 80,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  image: DecorationImage(
                                    image: AssetImage('assets/image/cat.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 104,
                            right: 16,
                            bottom: 8,
                            child: Row(
                              children: [
                                Text(
                                  viewModel.userInfo?.username ?? '로딩중입니다 띠리리..',
                                  style: const TextStyle(
                                    fontFamily: 'Pretendard',
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    context.go('/mypage/edit');
                                  },
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      color: Color(0xff403F3F),
                                    ),
                                    child: const Icon(
                                      Icons.settings,
                                      size: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // showEmptyBoxBottomSheet(context);
                                  },
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      color: Color(0xff403F3F),
                                    ),
                                    child: const Icon(
                                      Icons.ios_share,
                                      size: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 12),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 88),
                                const Text(
                                  '큐레이션',
                                  style: TextStyle(
                                    color: Color(0xff888888),
                                    fontFamily: 'Pretendard',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  '${viewModel.postCount ?? 0}개',
                                  style: const TextStyle(
                                    color: Color(0xff888888),
                                    fontFamily: 'Pretendard',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                const Text(
                                  '·',
                                  style: TextStyle(
                                    color: Color(0xff888888),
                                    fontFamily: 'Pretendard',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                const Text(
                                  '좋아요',
                                  style: TextStyle(
                                    color: Color(0xff888888),
                                    fontFamily: 'Pretendard',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  '${viewModel.likeCount ?? 0}개',
                                  style: const TextStyle(
                                    color: Color(0xff888888),
                                    fontFamily: 'Pretendard',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 260,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: 214,
                                      child: Text(
                                        viewModel.userInfo?.category ??
                                            "MZ의 시각으로 영화와 드라마를 추천 및 소개합니다.\n내 취향에 딱 맞는영화 확인 하는 방법\n가나다라마바사아자차카타파하\n거너더러머버서어저처커터퍼허퍼러너너머ㅓㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇ",
                                        maxLines: isExpanded ? null : 4,
                                        overflow: isExpanded
                                            ? TextOverflow.visible
                                            : TextOverflow.ellipsis,
                                        softWrap: true,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Pretendard',
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 216,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 0),
                                          minimumSize: const Size(0, 0),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isExpanded = !isExpanded;
                                          });
                                        },
                                        child: Text(
                                          isExpanded ? '접기' : '더 보기',
                                          style: const TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff888888),
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const CurationLogCarousel(),
// Test6 클래스의 build 메서드 내 Column 부분 수정
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          children: viewModel.userFeeds.isEmpty
                              ? [
                            const SizedBox(height: 24), // 상단 여백 추가
                            const Icon(
                              Icons.info_outline,
                              size: 48,
                              color: Color(0xff888888),
                            ),
                            const SizedBox(height: 8), // 아이콘과 텍스트 간격
                            const Text(
                              '아직 등록된 피드가 없습니다.',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff888888),
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8), // 텍스트와 버튼 간격
                            TextButton(
                              onPressed: () {
                                context.go('/community');
                                print('피드 추가 버튼 클릭');
                              },
                              child: const Text(
                                '피드 추가하기',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff3D3D3D),
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ]
                              : viewModel.userFeeds.map((feed) {
                            final dateFormat = DateFormat('yyyy.MM.dd');
                            return CurationCard(
                              imagePath: 'assets/image/cat.png',
                              title: feed.title,
                              description: feed.content,
                              likeCount: feed.sumLike,
                              viewCount: feed.hits,
                              date: dateFormat.format(feed.createdAt),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }
}