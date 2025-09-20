class RowData {
  RowData();

  List<String> get typeNames => ["Sex", "Solo", "Medical"];
  List<String> get typeSlugs => ["sex", "masturbation", "medical"];

  List<String> get categoryNames => ["Contraception", "Poses", "Practices", "Place", "Practices", "STI test", "OB-GYN visit"];
  List<String> get categorySlugs => ["contraception", "poses", "practices", "place", "solo practices", "sti", "obgyn"];


  List<String> get contraceptionOptionNames => [
    "Pulling out", "Condom",  "Pill", "Latex napkin", "IUD", "Spermicides", "Hormonal ring"
  ];
  List<String> get contraceptionOptionSlugs => [
    "pulling out", "condom",  "pill", "latex napkin", "iud", "spermicides", "hormonal ring"
  ];

  List<String> get posesOptionNames => [
    "Missionary", "Cowgirl", "Doggystyle", "CAT", "Standing", "Side", "Prone bone", "69", "Lotus", "Eagle", "Reverse cowgirl"
  ];
  List<String> get posesOptionSlugs => [
    "missionary", "cowgirl", "doggystyle", "cat", "standing", "side", "prone bone", "69", "lotus", "eagle", "reverse cowgirl"
  ];

  List<String> get practicesOptionNames => [
    "Vaginal", "Petting", "Frottage", "Dry humping", "Cunnilingus", "Blowjob", "Fingering", "Handjob", "Mutual masturbation",
    "Intermammary", "Intercrural", "Anal", "Rimming", "Pegging", "Bondage", "Chocking", "Toys", "Roleplay", "Waxplay",
  ];
  List<String> get practicesOptionSlugs => [
    "vaginal", "petting", "frottage", "dry humping", "cunnilingus", "blowjob", "fingering", "handjob", "mutual masturbation",
    "intermammary", "intercrural", "anal", "rimming", "pegging", "bondage", "chocking", "toys", "roleplay", "waxplay",
  ];

  List<String> get placeOptionNames => [
    "Bed", "Bathroom", "Table", "Chair", "Car", "Pool", "Office", "Hotel", "Beach", "Rooftop", "Forest", "Field",
    "School", "University", "My place", "Partner's place", "Public space"
  ];
  List<String> get placeOptionSlugs => [
    "bed", "bathroom", "table", "chair", "car", "pool", "office", "hotel", "beach", "rooftop", "forest", "field",
    "school", "university", "my place", "partner's place", "public space"
  ];

  List<String> get soloPracticesOptionNames => ["Porn", "Fingering", "Handjob", "Toys", "Frottage", "Anal"];
  List<String> get soloPracticesOptionSlugs => [
    "porn", "solo fingering", "solo handjob", "solo toys", "solo frottage", "solo anal"
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