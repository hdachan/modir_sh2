
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget curationcustomAppBar(
    BuildContext context,
    String title,
    ) {
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
            padding: const EdgeInsets.only(left: 24, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Pretendard',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),

                // more_vert 아이콘
                // IconButton(
                //   icon: const Icon(
                //     Icons.more_vert,
                //     color: Colors.black,
                //     size: 24,
                //   ),
                //   onPressed: () {
                //     print("more_vert 클릭");
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
