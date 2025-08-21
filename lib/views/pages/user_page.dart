import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/services/api_services.dart';
import 'package:instagram_clone/views/pages/video_page.dart';
import 'package:instagram_clone/views/widgets/button_card.dart';
import 'package:instagram_clone/views/widgets/category_info.dart';
import 'package:instagram_clone/views/widgets/custom_text.dart';
import 'package:instagram_clone/views/widgets/grid_skeleton.dart';
import 'package:instagram_clone/views/widgets/user_info.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';

class UserPage extends StatefulWidget {
  final Map info;

  const UserPage({super.key, required this.info});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late final String userName;
  List image = [
    "https://picsum.photos/200/300",
    "https://picsum.photos/200/300",
    "https://picsum.photos/200/300",
  ];
  List followers = [];
  List following = [];
  List posts = [];
  List reels = [];
  List mentions = [];

  Future<void> getFollowers() async {
    final result = await APIServices().fetchUserData('followers', userName);
    setState(() {
      followers = result;
    });
  }

  Future<void> getFollowing() async {
    final result = await APIServices().fetchUserData('following', userName);
    setState(() {
      following = result;
    });
  }

  Future<void> getPosts() async {
    final result = await APIServices().fetchUserData('posts', userName);
    setState(() {
      posts = result;
    });
  }

  Future<void> getReels() async {
    final result = await APIServices().fetchUserData('reels', userName);
    setState(() {
      reels = result;
    });
  }

  Future<void> getMentions() async {
    final result = await APIServices().fetchUserData('tagged', userName);
    setState(() {
      mentions = result;
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    userName = widget.info['username'];
    getFollowers();
    getFollowing();
    getPosts();
    getReels();
    getMentions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final info = widget.info;
    final category = info['category'];
    final username = info['username'];
    final userPicture = info['profile_pic_url_hd'];

    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: username, fontWeight: FontWeight.bold),
        centerTitle: false,
        leadingWidth: 30,
        actions: [
          Icon(Icons.notifications_none, color: Colors.white),
          SizedBox(width: 20),
          Icon(Icons.more_horiz, color: Colors.white),
          SizedBox(width: 20),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfo(
                  userImage: userPicture,
                  postsNumbers: posts.length.toString(),
                  followersNumbers: followers.length.toString(),
                  followingNumbers: following.length.toString(),
                ),
                SizedBox(height: 10),
                followers.isEmpty
                    ? Shimmer.fromColors(
                        baseColor: Colors.black,
                        highlightColor: Colors.grey,
                        child: CircleAvatar(radius: 20),
                      )
                    : CategoryInfo(
                        category: category,
                        image: [
                          followers[0]['profile_pic_url'] ??
                              "https://picsum.photos/200/300",
                          followers[1]['profile_pic_url'] ??
                              "https://picsum.photos/200/300",
                          followers[2]['profile_pic_url'] ??
                              "https://picsum.photos/200/300",
                        ],
                      ),
                SizedBox(height: 20),
                ButtonCard(),
              ],
            ),
          ),
          SizedBox(height: 30),
          TabBar(
            controller: tabController,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            dividerColor: Colors.black,
            labelPadding: EdgeInsets.all(10),
            indicatorColor: Colors.white,
            indicatorWeight: .3,
            indicatorSize: TabBarIndicatorSize.tab,
            dragStartBehavior: DragStartBehavior.start,
            tabs: [
              Icon(Icons.grid_on),
              Icon(Icons.video_collection_outlined, size: 25),
              Icon(Icons.person_add_alt, size: 28),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                // posts
                posts.isEmpty
                    ? GridSkeleton()
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          childAspectRatio: 1.1 / 2,
                        ),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return Stack(
                            children: [
                              Image.network(
                                post['thumbnail_url'],
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 4,
                                right: 6,
                                child: Icon(
                                  Icons.photo_library_outlined,
                                  size: 18,
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                // reels
                reels.isEmpty
                    ? GridSkeleton()
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          childAspectRatio: 0.9 / 1.6,
                        ),
                        itemCount: reels.length,
                        itemBuilder: (context, index) {
                          final reel = reels[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VideoPage(
                                  userName: username,
                                  userImage: userPicture,
                                  videoLink: reel['video_url'],
                                ),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Image.network(
                                  reel['thumbnail_url'],
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 8,
                                  left: 3,
                                  child: Icon(
                                    Icons.video_collection_outlined,
                                    size: 18,
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  left: 7,
                                  child: Row(
                                    children: [
                                      Icon(Ionicons.eye_outline, size: 18),
                                      SizedBox(width: 5),
                                      CustomText(text: "4,500"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                /// mention
                mentions.isEmpty
                    ? GridSkeleton()
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          childAspectRatio: 1.1 / 2,
                        ),
                        itemCount: mentions.length,
                        itemBuilder: (context, index) {
                          final mention = mentions[index];
                          return Stack(
                            children: [
                              Image.network(
                                mention['thumbnail_src'],
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 8,
                                left: 3,
                                child: Icon(
                                  Icons.video_collection_outlined,
                                  size: 18,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
