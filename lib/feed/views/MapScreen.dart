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
        viewModel.loadFeedCount(); // loadFeedCount 호출 추가
        return viewModel;
      },
      child: Consumer<FeedViewModel>(
        builder: (context, viewModel, child) {
          final screenWidth = MediaQuery.of(context).size.width;
          final crossAxisCount = screenWidth > 600 ? 3 : 2;

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
                      padding: const EdgeInsets.only(left: 16, right: 16),
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
                          : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: screenWidth > 600 ? 0.6 : 0.55,
                        ),
                        itemCount: viewModel.feeds.length,
                        itemBuilder: (context, index) {
                          Feed feed = viewModel.feeds[index];
                          return Card2(feed: feed);
                        },
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
                      shadows: [
                        BoxShadow(
                          color: const Color(0x14000000),
                          blurRadius: 8,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add, color: Colors.white, size: 16),
                        const SizedBox(width: 4),
                        const Text(
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

