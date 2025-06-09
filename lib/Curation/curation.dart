import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'CurationCard.dart';
import 'CurationLogCarousel.dart';
import 'ViewModel/Test6ViewModel.dart';
import 'curationwidget.dart';
import 'CurationShareSheet.dart';

bool isExpanded = false;

class Test6 extends StatefulWidget {
  const Test6({super.key});

  @override
  State<Test6> createState() => _Test6State();
}

class _Test6State extends State<Test6> {
  int currentPage = 0;
  bool _isProfileIncomplete = false;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      setState(() {
        _isLoggedIn = false;
      });
    } else {
      setState(() {
        _isLoggedIn = true;
      });
      print('Current userId: $userId');
      context.read<Test6ViewModel>().fetchUserData(userId).then((_) {
        final viewModel = context.read<Test6ViewModel>();
        setState(() {
          _isProfileIncomplete = viewModel.userInfo == null ||
              viewModel.userInfo!.username == null ||
              viewModel.userInfo!.category == null;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Test6ViewModel>(
      builder: (context, viewModel, child) {
        // _isProfileIncomplete를 뷰모델 상태로 다시 확인
        final isProfileIncomplete = viewModel.userInfo == null ||
            viewModel.userInfo!.username == null ||
            viewModel.userInfo!.category == null;

        return Scaffold(
          appBar: curationcustomAppBar(context, "마이 큐레이션"),
          body: !_isLoggedIn
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.login,
                  size: 48,
                  color: Color(0xff888888),
                ),
                const SizedBox(height: 16),
                const Text(
                  '로그인해주세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff3D3D3D),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    context.push('/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3D3D3D),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    textStyle: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  child: const Text('로그인'),
                ),
              ],
            ),
          )
              : viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : isProfileIncomplete
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 48,
                  color: Color(0xff888888),
                ),
                const SizedBox(height: 16),
                const Text(
                  '프로필 정보를 채워주세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff3D3D3D),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    context.push('/mypage/edit');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3D3D3D),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    textStyle: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  child: const Text('프로필 수정'),
                ),
              ],
            ),
          )
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
                        decoration: BoxDecoration(
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
                      Positioned(
                        left: 16,
                        bottom: -18,
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Icon(
                            Icons.person_rounded,
                            size: 60,
                            color: Colors.white,
                          )
                        ),
                      ),
                      Positioned(
                        left: 104,
                        right: 16,
                        bottom: 8,
                        child: Row(
                          children: [
                            Text(
                              viewModel.userInfo?.username ?? '이름 없음',
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
                                context.push('/mypage/edit');
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
                                showEmptyBoxBottomSheet(context);
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
                      top: 4,
                      left: 16,
                      right: 16,
                      bottom: 12,
                    ),
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
                                        '카테고리 정보 없음',
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
                                // Positioned(
                                //   bottom: 0,
                                //   left: 216,
                                //   child: TextButton(
                                //     style: TextButton.styleFrom(
                                //       padding: const EdgeInsets.symmetric(horizontal: 0),
                                //       minimumSize: const Size(0, 0),
                                //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                //     ),
                                //     onPressed: () {
                                //       setState(() {
                                //         isExpanded = !isExpanded;
                                //       });
                                //     },
                                //     child: Text(
                                //       isExpanded ? '접기' : '더 보기',
                                //       style: const TextStyle(
                                //         fontFamily: 'Pretendard',
                                //         fontSize: 10,
                                //         fontWeight: FontWeight.w500,
                                //         color: Color(0xff888888),
                                //         height: 1.4,
                                //       ),
                                //     ),
                                //   ),
                                // ), 더 보기 원할 때 보이기 안돼서 잠시 주석 처리
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const CurationLogCarousel(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      children: viewModel.userFeeds.isEmpty
                          ? [
                        const SizedBox(height: 24),
                        const Icon(
                          Icons.info_outline,
                          size: 48,
                          color: Color(0xff888888),
                        ),
                        const SizedBox(height: 8),
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
                        const SizedBox(height: 8),
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
                          imagePath: 'assets/image/hide_image.png',
                          title: feed.title,
                          description: feed.content,
                          likeCount: feed.sumLike,
                          viewCount: feed.hits,
                          date: dateFormat.format(feed.createdAt),
                          onTap: () {
                            context.push('/community/detail/${feed.feedId}');
                          },
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