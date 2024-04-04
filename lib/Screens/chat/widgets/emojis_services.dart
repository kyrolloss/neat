




import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class EmojisServices {
  static const _platform = MethodChannel('emoji_picker_flutter');
  Future<CategoryEmoji> getCategoryEmojis({required CategoryEmoji category}) async {
    var available = await _getSupportEmojis(category.emoji.map((e) => e.emoji).toList());
    return category.copyWith(emoji: [
      for(int i =0 ; i< available!.length; i++)
        if(available[i]) category.emoji[i]
    ]);
  }
  Future<List<bool>?> _getSupportEmojis(List<String> emojis) async {
    return await _platform.invokeListMethod<bool>('getSupportEmojis', {'source': emojis});
  }

  Future<List<CategoryEmoji>> filterUnsupported({required List<CategoryEmoji> data}) async {
    final futures = [for (final cat in data) getCategoryEmojis(category: cat)];
    return await Future.wait(futures);
  }
}

