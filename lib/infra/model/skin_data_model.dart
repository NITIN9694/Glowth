
class SkinDataModel {
  String? faceShape;
  String? skinType;
  String? gender;
  List<Hairstyles>? hairstyles;
  HairstyleTips? hairstyleTips;
  List<String>? skincareRoutinesMorning;
  List<String>? skincareRoutinesEvening;
  List<SkincareByGender>? skincareByGender;

  SkinDataModel(
      {this.faceShape,
        this.skinType,
        this.gender,
        this.hairstyles,
        this.hairstyleTips,
        this.skincareRoutinesMorning,
        this.skincareRoutinesEvening,
        this.skincareByGender});

  SkinDataModel.fromJson(Map<String, dynamic> json) {
    faceShape = json['face_shape'];
    skinType = json['skin_type'];
    gender = json['gender'];
    if (json['hairstyles'] != null) {
      hairstyles = <Hairstyles>[];
      json['hairstyles'].forEach((v) {
        hairstyles!.add(new Hairstyles.fromJson(v));
      });
    }
    hairstyleTips = json['hairstyle_tips'] != null
        ? new HairstyleTips.fromJson(json['hairstyle_tips'])
        : null;
    skincareRoutinesMorning = json['skincare_routines_morning'].cast<String>();
    skincareRoutinesEvening = json['skincare_routines_evening'].cast<String>();
    if (json['skincare_by_gender'] != null) {
      skincareByGender = <SkincareByGender>[];
      json['skincare_by_gender'].forEach((v) {
        skincareByGender!.add(new SkincareByGender.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['face_shape'] = this.faceShape;
    data['skin_type'] = this.skinType;
    data['gender'] = this.gender;
    if (this.hairstyles != null) {
      data['hairstyles'] = this.hairstyles!.map((v) => v.toJson()).toList();
    }
    if (this.hairstyleTips != null) {
      data['hairstyle_tips'] = this.hairstyleTips!.toJson();
    }
    data['skincare_routines_morning'] = this.skincareRoutinesMorning;
    data['skincare_routines_evening'] = this.skincareRoutinesEvening;
    if (this.skincareByGender != null) {
      data['skincare_by_gender'] =
          this.skincareByGender!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hairstyles {
  String? name;
  String? description;
  String? imageUrl;
  String? difficulty;
  String? maintenance;
  List<String>? hairType;
  String? gender;

  Hairstyles(
      {this.name,
        this.description,
        this.imageUrl,
        this.difficulty,
        this.maintenance,
        this.hairType,
        this.gender});

  Hairstyles.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    imageUrl = json['image_url'];
    difficulty = json['difficulty'];
    maintenance = json['maintenance'];
    hairType = json['hair_type'].cast<String>();
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    data['difficulty'] = this.difficulty;
    data['maintenance'] = this.maintenance;
    data['hair_type'] = this.hairType;
    data['gender'] = this.gender;
    return data;
  }
}

class HairstyleTips {
  String? bestFeatures;
  String? avoid;
  List<String>? recommendedProducts;

  HairstyleTips({this.bestFeatures, this.avoid, this.recommendedProducts});

  HairstyleTips.fromJson(Map<String, dynamic> json) {
    bestFeatures = json['best_features'];
    avoid = json['avoid'];
    recommendedProducts = json['recommended_products'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['best_features'] = this.bestFeatures;
    data['avoid'] = this.avoid;
    data['recommended_products'] = this.recommendedProducts;
    return data;
  }
}

class SkincareByGender {
  String? name;
  String? description;
  String? imageUrl;
  List<String>? keyIngredients;
  String? priceRange;
  String? application;
  List<String>? benefits;

  SkincareByGender(
      {this.name,
        this.description,
        this.imageUrl,
        this.keyIngredients,
        this.priceRange,
        this.application,
        this.benefits});

  SkincareByGender.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    imageUrl = json['image_url'];
    keyIngredients = json['key_ingredients'].cast<String>();
    priceRange = json['price_range'];
    application = json['application'];
    benefits = json['benefits'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    data['key_ingredients'] = this.keyIngredients;
    data['price_range'] = this.priceRange;
    data['application'] = this.application;
    data['benefits'] = this.benefits;
    return data;
  }
}
