// import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:academia/New%20folder/common/error_page.dart';
import 'package:academia/New%20folder/common/loading_page.dart';
import 'package:academia/New%20folder/constants/assets_constants.dart';
import 'package:academia/New%20folder/core/enums/tweet_type_enum.dart';
import 'package:academia/New%20folder/features/auth/controller/auth_controller.dart';
import 'package:academia/New%20folder/features/tweets/controller/tweet_controller.dart';
import 'package:academia/New%20folder/features/tweets/view/twitter_reply_view.dart';
import 'package:academia/New%20folder/features/tweets/widgets/carousel_image.dart';
import 'package:academia/New%20folder/features/tweets/widgets/hashtag_text.dart';
import 'package:academia/New%20folder/features/tweets/widgets/tweet_icon_button.dart';
import 'package:academia/New%20folder/features/user_profile/view/user_profile_view.dart';
import 'package:academia/New%20folder/models/tweet_model.dart';
import 'package:academia/New%20folder/theme/pallete.dart';

// import 'package:timeago/timeago.dart' as timeago;

class TweetCard extends ConsumerWidget {
  final Tweet tweet;
  const TweetCard({
    super.key,
    required this.tweet,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;

    return currentUser == null
        ? const SizedBox()
        : ref.watch(userDetailsProvider(tweet.uid)).when(
              data: (user) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      TwitterReplyScreen.route(tweet),
                    );
                  },
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  UserProfileView.route(user),
                                );
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(user.profilePic),
                                radius: 35,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (tweet.retweetedBy.isNotEmpty)
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AssetsConstants.retweetIcon,
                                        color: Pallete.greyColor,
                                        height: 20,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${tweet.retweetedBy} retweeted',
                                        style: const TextStyle(
                                          color: Pallete.greyColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                Row(
                                  children: [
                                  Text('@${user.name}',style: const TextStyle(
                                    //     color: Pallete.greyColor,
                                    //Z     fontSize: 17,
                                     ),)
                                    // Text(
                                    //   '@${user.name} · ${timeago.format(
                                    //     tweet.tweetedAt,
                                    //     locale: 'en_short',
                                    //   )}',
                                    //   style: const TextStyle(
                                    //     color: Pallete.greyColor,
                                    //     fontSize: 17,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                if (tweet.repliedTo.isNotEmpty)
                                  ref
                                      .watch(
                                          getTweetByIdProvider(tweet.repliedTo))
                                      .when(
                                        data: (repliedToTweet) {
                                          final replyingToUser = ref
                                              .watch(
                                                userDetailsProvider(
                                                  repliedToTweet.uid,
                                                ),
                                              )
                                              .value;
                                          return RichText(
                                            text: TextSpan(
                                              text: 'Replying to',
                                              style: const TextStyle(
                                                color: Pallete.greyColor,
                                                fontSize: 16,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      ' @${replyingToUser?.name}',
                                                  style: const TextStyle(
                                                    color: Pallete.blueColor,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        error: (error, st) => ErrorText(
                                          error: error.toString(),
                                        ),
                                        loading: () => const SizedBox(),
                                      ),
                                HashtagText(text: tweet.text),
                                if (tweet.tweetType == TweetType.image)
                                  CarouselImage(imageLinks: tweet.imageLinks),
                                if (tweet.link.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  // b
                                ],
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    right: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      // TweetIconButton(
                                      //   pathName: AssetsConstants.viewsIcon,
                                      //   text: (tweet.commentIds.length +
                                      //           tweet.reshareCount +
                                      //           tweet.likes.length)
                                      //       .toString(),
                                      //   onTap: () {},
                                      // ),
                                      TweetIconButton(
                                        pathName: AssetsConstants.commentIcon,
                                        text:
                                            tweet.commentIds.length.toString(),
                                        onTap: () {},
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      TweetIconButton(
                                        pathName: AssetsConstants.retweetIcon,
                                        text: tweet.reshareCount.toString(),
                                        onTap: () {
                                          ref
                                              .read(tweetControllerProvider
                                                  .notifier)
                                              .reshareTweet(
                                                tweet,
                                                currentUser,
                                                context,
                                              );
                                        },
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      LikeButton(
                                        size: 25,
                                        onTap: (isLiked) async {
                                          ref
                                              .read(tweetControllerProvider
                                                  .notifier)
                                              .likeTweet(
                                                tweet,
                                                currentUser,
                                              );
                                          return !isLiked;
                                        },
                                        isLiked: tweet.likes
                                            .contains(currentUser.uid),
                                        likeBuilder: (isLiked) {
                                          return isLiked
                                              ? SvgPicture.asset(
                                                  AssetsConstants
                                                      .likeFilledIcon,
                                                  color: Pallete.redColor,
                                                )
                                              : SvgPicture.asset(
                                                  AssetsConstants
                                                      .likeOutlinedIcon,
                                                  color: Pallete.greyColor,
                                                );
                                        },
                                        likeCount: tweet.likes.length,
                                        countBuilder:
                                            (likeCount, isLiked, text) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2.0),
                                            child: Text(
                                              text,
                                              style: TextStyle(
                                                color: isLiked
                                                    ? Pallete.redColor
                                                    : Pallete.whiteColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      // IconButton(
                                      //   onPressed: () {},
                                      //   icon: const Icon(
                                      //     Icons.share_outlined,
                                      //     size: 25,
                                      //     color: Pallete.greyColor,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 1),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Pallete.greyColor),
                    ],
                  ),
                );
              },
              error: (error, stackTrace) => ErrorText(
                error: error.toString(),
              ),
              loading: () => const Loader(),
            );
  }
}
