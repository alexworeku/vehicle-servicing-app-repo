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

  Map<String, dynamic> toMap({bool isForOffline = false}) {
    return <String, dynamic>{
      'Id': id,
      'Title': title,
      'Duration': duration,
      'Content': content,
      'Likes': likes,
      'ImageUrl': imageUrl,
      'Tags': isForOffline ? _mergeTags(tags) : tags,
      'RegisteredDate': date,
      'ChannelId': channelId
    };
  }

  ArticlePost.fromMap(String id, Map<String, dynamic> data,
      {isForOffline = false}) {
    this.id = id;
    this.title = data['Title'];
    this.content = data['Content'];
    this.duration = data['Duration'];
    this.likes = data['Likes'];
    this.imageUrl = data['ImageUrl'];
    this.tags = isForOffline
        ? _splitTags(data['Tags'])
        : List<String>.from(data['Tags']);
    this.date = data['RegisteredDate'];
    this.channelId = data['ChannelId'];
  }
  String _mergeTags(List<String> tags) {
    String mergedTags = "#";
    mergedTags += tags.join("#");
    return mergedTags;
  }

  List<String> _splitTags(String tags) {
    return tags.split("#");
  }
}
