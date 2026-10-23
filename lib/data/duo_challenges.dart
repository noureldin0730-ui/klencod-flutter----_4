class DuoChallenge {
  final String text;
  final String category;
  final String emoji;

  const DuoChallenge({
    required this.text,
    required this.category,
    required this.emoji,
  });
}

class DuoChallengesData {
  static const List<DuoChallenge> all = [
    // 🎤 غنا
    DuoChallenge(text: 'غنّوا أغنية مع بعض', category: 'غنا', emoji: '🎤'),
    DuoChallenge(text: 'كل واحد يغني مقطع والتاني يكمل', category: 'غنا', emoji: '🎤'),
    DuoChallenge(text: 'غنّوا أغنية أطفال مع بعض', category: 'غنا', emoji: '🎤'),
    DuoChallenge(text: 'غنّوا نشيد وطني مع بعض', category: 'غنا', emoji: '🎤'),
    DuoChallenge(text: 'غنّوا أغنية عمرو دياب مع بعض', category: 'غنا', emoji: '🎤'),
    DuoChallenge(text: 'غنّوا أغنية أم كلثوم مع بعض', category: 'غنا', emoji: '🎤'),
    DuoChallenge(text: 'غنّوا أغنية مهرجان شعبي مع بعض', category: 'غنا', emoji: '🎤'),
    DuoChallenge(text: 'كل واحد يغني بصوت حيوان والتاني يقلده', category: 'غنا', emoji: '🎤'),

    // 🗣️ كلام
    DuoChallenge(text: 'اتكلموا بصوت واحد 30 ثانية', category: 'كلام', emoji: '🗣️'),
    DuoChallenge(text: 'قولوا جملة كل واحد يكملها', category: 'كلام', emoji: '💬'),
    DuoChallenge(text: 'قولوا 5 أكلات مصرية بالتناوب', category: 'كلام', emoji: '🍔'),
    DuoChallenge(text: 'عدوا من 1 لـ 20 بالتناوب', category: 'كلام', emoji: '🔢'),
    DuoChallenge(text: 'قولوا 5 أسماء أولاد بحرف الميم', category: 'كلام', emoji: '🗣️'),
    DuoChallenge(text: 'قولوا 5 أسماء بنات بحرف النون', category: 'كلام', emoji: '🗣️'),
    DuoChallenge(text: 'اتكلموا عن بعض لمدة دقيقة', category: 'كلام', emoji: '💬'),
    DuoChallenge(text: 'كل واحد يقول حاجة بيحبها في التاني', category: 'كلام', emoji: '❤️'),
    DuoChallenge(text: 'قولوا مثل مصري بالتناوب', category: 'كلام', emoji: '🗣️'),
    DuoChallenge(text: 'قولوا 5 محافظات مصرية بالتناوب', category: 'كلام', emoji: '🗺️'),
    DuoChallenge(text: 'كل واحد يحكي موقف مضحك حصله', category: 'كلام', emoji: '💬'),
    DuoChallenge(text: 'اتكلموا بالانجليزي لمدة دقيقة', category: 'كلام', emoji: '🇬🇧'),

    // 🎭 تمثيل
    DuoChallenge(text: 'مثّلوا مشهد تمثيلي مع بعض', category: 'تمثيل', emoji: '🎭'),
    DuoChallenge(text: 'قلدوا نفس الشخصية مع بعض', category: 'تمثيل', emoji: '😎'),
    DuoChallenge(text: 'مثّلوا إنكم في مطعم مع بعض', category: 'تمثيل', emoji: '🍽️'),
    DuoChallenge(text: 'مثّلوا إنكم بتتخانقوا مع بعض', category: 'تمثيل', emoji: '😡'),
    DuoChallenge(text: 'مثّلوا مشهد درامي مع بعض', category: 'تمثيل', emoji: '🎬'),
    DuoChallenge(text: 'مثّلوا إنكم عيانين مع بعض', category: 'تمثيل', emoji: '🏥'),
    DuoChallenge(text: 'مثّلوا إنكم في فرح مع بعض', category: 'تمثيل', emoji: '🎉'),
    DuoChallenge(text: 'مثّلوا إنكم سواقين ميكروباص مع بعض', category: 'تمثيل', emoji: '🚐'),
    DuoChallenge(text: 'مثّلوا إنكم مدرسين مع بعض', category: 'تمثيل', emoji: '🏫'),
    DuoChallenge(text: 'مثّلوا إنكم في زحمة مع بعض', category: 'تمثيل', emoji: '🚗'),

    // 💃 حركة
    DuoChallenge(text: 'ارقصوا مع بعض 10 ثواني', category: 'حركة', emoji: '💃'),
    DuoChallenge(text: 'اعملوا ضغط 5 مرات مع بعض', category: 'حركة', emoji: '💪'),
    DuoChallenge(text: 'اعملوا سكوات 5 مرات مع بعض', category: 'حركة', emoji: '🏋️'),
    DuoChallenge(text: 'امشوا زي البط مع بعض', category: 'حركة', emoji: '🦆'),
    DuoChallenge(text: 'اقفزوا 10 قفزات مع بعض', category: 'حركة', emoji: '🤸'),
    DuoChallenge(text: 'امشوا زي القطط مع بعض', category: 'حركة', emoji: '🐈'),
    DuoChallenge(text: 'اقفوا على رجل واحدة 30 ثانية مع بعض', category: 'حركة', emoji: '🦵'),
    DuoChallenge(text: 'اعملوا تمرين معدة 10 مرات مع بعض', category: 'حركة', emoji: '🤸'),

    // 😂 مضحك
    DuoChallenge(text: 'اضحكوا بصوت عالي مع بعض', category: 'مضحك', emoji: '😂'),
    DuoChallenge(text: 'قلدوا صوت حيوان مع بعض', category: 'مضحك', emoji: '🐈'),
    DuoChallenge(text: 'اعملوا وشوش غريبة مع بعض', category: 'مضحك', emoji: '🤪'),
    DuoChallenge(text: 'اتكلموا بالمقلوب مع بعض', category: 'مضحك', emoji: '🙃'),
    DuoChallenge(text: 'اعملوا ضحكة شريرة مع بعض', category: 'مضحك', emoji: '😈'),
    DuoChallenge(text: 'قلدوا بعض بالحركات مع بعض', category: 'مضحك', emoji: '🪞'),

    // 🤝 اجتماعي
    DuoChallenge(text: 'اسلموا على بعض بطريقة مضحكة', category: 'اجتماعي', emoji: '🤝'),
    DuoChallenge(text: 'خدوا سيلفي مع بعض', category: 'اجتماعي', emoji: '📸'),
    DuoChallenge(text: 'اعملوا هاي فايف مع بعض', category: 'اجتماعي', emoji: '🙌'),
    DuoChallenge(text: 'كل واحد يمدح التاني 30 ثانية', category: 'اجتماعي', emoji: '🌟'),
    DuoChallenge(text: 'اتفقوا على حاجة واحدة تعملوها بعد اللعبة', category: 'اجتماعي', emoji: '🤝'),
    DuoChallenge(text: 'اتصلوا على صاحبكم وغنوا له مع بعض', category: 'اجتماعي', emoji: '📞'),
    DuoChallenge(text: 'قولوا سر لبعض', category: 'اجتماعي', emoji: '🤫'),
    DuoChallenge(text: 'كل واحد يقلد التاني', category: 'اجتماعي', emoji: '🪞'),

    // 🤪 تحديات غريبة
    DuoChallenge(text: 'بصوا في عين بعض 30 ثانية من غير ضحك', category: 'غريب', emoji: '👀'),
    DuoChallenge(text: 'اقعدوا على الأرض مع بعض', category: 'غريب', emoji: '🧘'),
    DuoChallenge(text: 'اقفزوا قفزة مع بعض', category: 'غريب', emoji: '🤸'),
    DuoChallenge(text: 'اتخانقوا بالكلام مع بعض لمدة دقيقة', category: 'غريب', emoji: '🗣️'),
    DuoChallenge(text: 'صلحوا خناقة وهمية مع بعض', category: 'غريب', emoji: '🤝'),
  ];
}