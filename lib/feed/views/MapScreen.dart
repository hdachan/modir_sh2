import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../widget/feed_widget.dart';
import '../viewmodels/FeedViewModel.dart';
import '../models/Feedmodel.dart';
import 'LikedFeedScreen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = FeedViewModel();
        viewModel.fetchFeeds();
        viewModel.loadFeedCount();
        return viewModel;
      },
      child: Consumer<FeedViewModel>(
        builder: (context, viewModel, child) {
          final screenWidth = MediaQuery.of(context).size.width;
          const double cardWidth = 170; // 카드 고정 너비 << 우선 임시로 170으로 고정하고 card 중앙 고정 제목이 길어지면 화면 오류남. 제목 텍스트 길이 정해 놓는게 좋을 듯
          const double crossAxisSpacing = 8;

          // 화면 너비 최대 600으로 제한 (ConstrainedBox 기준)
          final constrainedWidth = screenWidth.clamp(360.0, 600.0);

          // crossAxisCount는 카드 고정 너비와 간격 기준 계산
          int crossAxisCount = (constrainedWidth / (cardWidth + crossAxisSpacing)).floor();
          if (crossAxisCount < 1) crossAxisCount = 1;

          // 실제 GridView 폭 = 카드 너비 * 열 개수 + 간격 * (열 개수 - 1)
          final gridViewWidth = cardWidth * crossAxisCount + crossAxisSpacing * (crossAxisCount - 1);

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Scaffold(
                body: Column(
                  children: [
                    customAppBar(),
                    customBodyBar(context, "모디랑 커뮤니티 이용수칙 안내"),
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            '총 ${viewModel.feedCount} 건',
                            style: const TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              height: 1.30,
                              letterSpacing: -0.30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: viewModel.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : viewModel.feeds.isEmpty
                          ? const Center(child: Text('피드가 없습니다.'))
                          : Center(
                        child: SizedBox(
                          width: gridViewWidth,
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: crossAxisSpacing,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.6,
                            ),
                            itemCount: viewModel.feeds.length,
                            itemBuilder: (context, index) {
                              Feed feed = viewModel.feeds[index];
                              return SizedBox(
                                width: cardWidth,
                                child: Card2(feed: feed),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.white,
                floatingActionButton: GestureDetector(
                  onTap: () {
                    context.go('/community/write');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF3D3D3D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 8,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.add, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '글쓰기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
