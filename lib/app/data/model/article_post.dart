import 'package:vehicleservicingapp/app/data/model/post.dart';

class ArticlePost extends Post {
  String title;
  String content;
  int duration; //in minutes
  int likes;
  ArticlePost({
    this.title,
    this.duration,
    this.content,
    this.likes,
    String imageUrl,
    List<String> tags,
    String date,
    String channelId,
  }) : super(imageUrl: imageUrl, tags: tags, date: date, channelId: channelId);
}
