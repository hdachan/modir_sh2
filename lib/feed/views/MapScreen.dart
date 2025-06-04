import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../widget/feed_widget.dart';
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
                    customBodyBar(context, "공지"),
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
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    context.go('/community/write');
                  },
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.edit, color: Colors.white),
                  tooltip: '글쓰기',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

