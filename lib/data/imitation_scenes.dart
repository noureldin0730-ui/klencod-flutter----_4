class ImitationScene {
  final String text;
  final String emoji;

  const ImitationScene({
    required this.text,
    required this.emoji,
  });
}

class ImitationScenesData {
  static const List<ImitationScene> all = [
    // 💃 حركات ومشي
    ImitationScene(text: 'قلّد شكل صاحبك', emoji: '😎'),
    ImitationScene(text: 'قلّد مشيته', emoji: '🚶'),
    ImitationScene(text: 'قلّد طريقة قعدته', emoji: '🪑'),
    ImitationScene(text: 'قلّد رقصة صاحبك', emoji: '🕺'),
    ImitationScene(text: 'قلّد طريقة وقفته', emoji: '🧍'),
    ImitationScene(text: 'قلّد طريقة جريته', emoji: '🏃'),
    ImitationScene(text: 'قلّد طريقة نومه', emoji: '🛌'),
    ImitationScene(text: 'قلّد طريقة قفزه', emoji: '🤸'),

    // 🗣️ كلام وأصوات
    ImitationScene(text: 'قلّد صوت صاحبك', emoji: '🗣️'),
    ImitationScene(text: 'قلّد طريقة كلامه', emoji: '💬'),
    ImitationScene(text: 'قلّد ضحكته', emoji: '😂'),
    ImitationScene(text: 'قلّد طريقة غناه', emoji: '🎤'),
    ImitationScene(text: 'قلّد طريقة صوته لما بيزعق', emoji: '😡'),
    ImitationScene(text: 'قلّد طريقة صاحبك في التريقة على حد', emoji: '🗣️'), // ← التعديل هنا
    ImitationScene(text: 'قلّد طريقة صوته في التليفون', emoji: '📞'),
    ImitationScene(text: 'قلّد طريقة سؤاله', emoji: '❓'),

    // 🍔 أكل وشرب
    ImitationScene(text: 'قلّد طريقة أكله', emoji: '🍔'),
    ImitationScene(text: 'قلّد طريقة شربه للشاي', emoji: '☕'),
    ImitationScene(text: 'قلّد طريقة أكله للشيبسي', emoji: '🍟'),
    ImitationScene(text: 'قلّد طريقة أكله للمانجا', emoji: '🥭'),
    ImitationScene(text: 'قلّد طريقة شربه للمية', emoji: '💧'),
    ImitationScene(text: 'قلّد طريقة أكله للكبدة', emoji: '🍖'),

    // 📱 حاجات يومية
    ImitationScene(text: 'قلّد ماسكه للتليفون', emoji: '📱'),
    ImitationScene(text: 'قلّد طريقة كتابته على الموبايل', emoji: '⌨️'),
    ImitationScene(text: 'قلّد طريقة تصويره سيلفي', emoji: '📸'),
    ImitationScene(text: 'قلّد طريقة تفكيره', emoji: '🤔'),
    ImitationScene(text: 'قلّد طريقته في الغضب', emoji: '😡'),
    ImitationScene(text: 'قلّد طريقة تنظيفه لودانه', emoji: '👂'),
    ImitationScene(text: 'قلّد طريقة سلامه', emoji: '🤝'),
    ImitationScene(text: 'قلّد طريقة نومه على السرير', emoji: '🛌'),
    ImitationScene(text: 'قلّد طريقة لبسه للهدوم', emoji: '👕'),

    // 😂 مواقف مضحكة
    ImitationScene(text: 'قلّد صاحبك لما بيشوف حاجة بتخوفه', emoji: '😱'),
    ImitationScene(text: 'قلّد صاحبك لما بياخد فلوس', emoji: '💰'),
    ImitationScene(text: 'قلّد صاحبك لما بياكل حاجة حارة', emoji: '🌶️'),
    ImitationScene(text: 'قلّد صاحبك لما بيصحى من النوم', emoji: '😴'),
    ImitationScene(text: 'قلّد صاحبك لما بيكسب', emoji: '🏆'),
    ImitationScene(text: 'قلّد صاحبك لما بيخسر', emoji: '😭'),
    ImitationScene(text: 'قلّد صاحبك لما بيتكسف', emoji: '😳'),
    ImitationScene(text: 'قلّد صاحبك لما بيكدب', emoji: '🤥'),
    ImitationScene(text: 'قلّد صاحبك لما بيعيط', emoji: '😢'),
    ImitationScene(text: 'قلّد صاحبك لما بينسى حاجة', emoji: '🤦‍♂️'),

    // 🏃‍♂️ رياضة وحركة
    ImitationScene(text: 'قلّد طريقة لعب صاحبك للكورة', emoji: '⚽'),
    ImitationScene(text: 'قلّد طريقة نطته للحبل', emoji: '🪢'),
    ImitationScene(text: 'قلّد طريقة سباحته', emoji: '🏊'),
    ImitationScene(text: 'قلّد طريقة ركوبه للدراجة', emoji: '🚴'),

    // 🎭 شخصيات
    ImitationScene(text: 'قلّد صاحبك وهو بيمثل', emoji: '🎭'),
    ImitationScene(text: 'قلّد صاحبك وهو مغني', emoji: '🎤'),
    ImitationScene(text: 'قلّد صاحبك وهو مذيع', emoji: '🎙️'),
    ImitationScene(text: 'قلّد صاحبك وهو مدرس', emoji: '🏫'),

    // 🤪 حركات غريبة
    ImitationScene(text: 'قلّد صاحبك وهو بيعطس', emoji: '🤧'),
    ImitationScene(text: 'قلّد صاحبك وهو بيكح', emoji: '😷'),
    ImitationScene(text: 'قلّد صاحبك وهو بيتثاوب', emoji: '🥱'),
    ImitationScene(text: 'قلّد صاحبك وهو بيفكر', emoji: '🤔'),
  ];
}