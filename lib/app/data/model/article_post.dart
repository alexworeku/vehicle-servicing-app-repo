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
    String id,
    String imageUrl,
    List<String> tags,
    String date,
    String channelId,
  }) : super(
            id: id,
            imageUrl: imageUrl,
            tags: tags,
            date: date,
            channelId: channelId);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': id,
      'Title': title,
      'Duration': duration,
      'Content': content,
      'Likes': likes,
      'ImageUrl': imageUrl,
      'Tags': tags,
      'RegisteredDate': date,
      'ChannelId': channelId
    };
  }

  ArticlePost.fromMap(String id, Map<String, dynamic> data)
      : this(
          id: id,
          title: data['Title'],
          content: data['Content'],
          duration: data['Duration'],
          likes: data['Likes'],
          imageUrl: data['ImageUrl'],
          tags: List<String>.from(data['Tags']),
          date: data['RegisteredDate'],
          channelId: data['ChannelId'],
        );
}
