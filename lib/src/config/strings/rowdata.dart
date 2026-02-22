class RowData {
  RowData();

  List<String> get typeNames => ["Sex", "Solo", "Medical"];
  List<String> get typeSlugs => ["sex", "masturbation", "medical"];

  List<String> get categoryNames => [
    "Contraception", "Poses", "Practices", "Ejaculation", "Place",
    "Practices", "Complicacies", "STI test", "OB-GYN visit",
  ];
  List<String> get categorySlugs => [
    "contraception", "poses", "practices", "ejaculation", "place",
    "solo practices", "complicacies", "sti", "obgyn",
  ];


  List<String> get contraceptionOptionNames => [
    "Pulling out", "Condom", "Pill", "Latex napkin", "IUD", "Spermicides", "Hormonal ring", "Vasectomy"
  ];
  List<String> get contraceptionOptionSlugs => [
    "pulling out", "condom", "pill", "latex napkin", "iud", "spermicides", "hormonal ring", "vasectomy"
  ];

  List<String> get posesOptionNames => [
    "Missionary", "Legs on shoulders", "CAT",
    "Cowgirl", "Reverse cowgirl",
    "Doggystyle", "Prone bone",
    "Standing", "Standing from behind",
    "Side", "69", "Lotus",
  ];
  List<String> get posesOptionSlugs => [
    "missionary", "legs on shoulders", "cat",
    "cowgirl", "reverse cowgirl",
    "doggystyle", "prone bone",
    "standing", "standing from behind",
    "side", "69", "lotus",
  ];

  List<String> get practicesOptionNames => [
    "Vaginal", "Petting", "Frottage", "Cunnilingus", "Blowjob", "Fingering", "Handjob", "Mutual masturbation",
    "Intermammary", "Intercrural", "Anal", "Rimming", "Pegging", "Bondage", "Choking", "Toy usage", "Roleplay", "Waxplay",
    "Spanking", "Handcuffing", "Tying up", "Masturbation"
  ];
  List<String> get practicesOptionSlugs => [
    "vaginal", "petting", "frottage", "cunnilingus", "blowjob", "fingering", "handjob", "mutual masturbation",
    "intermammary", "intercrural", "anal", "rimming", "pegging", "bondage", "choking", "toy usage", "roleplay", "waxplay",
    "spanking", "handcuffing", "tying up", "masturbation"
  ];

  List<String> get ejaculationOptionNames => [
    "No ejaculation", "In condom", "Inside vagina", "Inside rectum", "In mouth",
    "On back", "On stomach", "On neck", "On face", "On feet", "On buttocks",
    "On surroundings"
  ];
  List<String> get ejaculationOptionSlugs => [
    "no ejaculation", "in condom", "inside vagina", "inside rectum", "in mouth",
    "on back", "on stomach", "on neck", "on face", "on feet", "on buttocks",
    "on surroundings"
  ];

  List<String> get placeOptionNames => [
    "Bed", "Bathroom", "Table", "Chair", "Car", "Pool", "Office", "Hotel", "Beach", "Rooftop", "Forest", "Field",
    "School", "University", "My place", "Partner's place", "Public space"
  ];
  List<String> get placeOptionSlugs => [
    "bed", "bathroom", "table", "chair", "car", "pool", "office", "hotel", "beach", "rooftop", "forest", "field",
    "school", "university", "my place", "partner's place", "public space"
  ];

  List<String> get complicaciesOptionNames => [
    "Menstruation", "Soreness", "Pain upon penetration", "Cervix pain", "Weak erection", "Unwanted activity"
  ];
  List<String> get complicaciesOptionSlugs => [
    "menstruation", "soreness", "pain upon penetration", "cervix pain", "weak erection", "unwanted activity"
  ];

  List<String> get soloPracticesOptionNames => ["Fingering", "Handjob", "Frottage", "Anal"];
  List<String> get soloPracticesOptionSlugs => [
    "solo fingering", "solo handjob", "solo frottage", "solo anal"
  ];

  List<String> get stiOptionNames => [
    "HIV", "Syphilis", "HPV", "Chlamydia", "Gonorrhea", "Trichomoniasis", "Mycoplasma", "Hepatitis B",
    "Molluscum contagiosum", "Herpes"
  ];
  List<String> get stiOptionSlugs => [
    "hiv", "syphilis", "hpv", "chlamydia", "honorrhea", "trichomoniasis", "mycoplasma", "hepatitis b",
    "molluscum contagiosum", "herpes"
  ];

  List<String> get obgynOptionNames => [
    "Pregnancy test", "Ultrasonography", "Pelvic exam"
  ];
  List<String> get obgynOptionSlugs => [
    "pregnancy test", "ultrasonography", "pelvic exam"
  ];
}