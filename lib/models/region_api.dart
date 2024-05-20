class DataApiRegion {
  List<Data>? data;
  Links? links;
  Meta? meta;

  DataApiRegion({this.data, this.links, this.meta});

  DataApiRegion.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? slug;
  String? tdwgCode;
  int? tdwgLevel;
  int? speciesCount;
  Links? links;
  Parent? parent;
  List<Data>? children; // Changed from List<Children> to List<Data>

  Data({
    this.id,
    this.name,
    this.slug,
    this.tdwgCode,
    this.tdwgLevel,
    this.speciesCount,
    this.links,
    this.parent,
    this.children,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    tdwgCode = json['tdwg_code'];
    tdwgLevel = json['tdwg_level'];
    speciesCount = json['species_count'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    parent = json['parent'] != null ? Parent.fromJson(json['parent']) : null;
    if (json['children'] != null) {
      children = <Data>[];
      json['children'].forEach((v) {
        children!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['tdwg_code'] = this.tdwgCode;
    data['tdwg_level'] = this.tdwgLevel;
    data['species_count'] = this.speciesCount;
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Links {
  String? self;
  String? plants;
  String? species;

  Links({this.self, this.plants, this.species});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    plants = json['plants'];
    species = json['species'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['self'] = this.self;
    data['plants'] = this.plants;
    data['species'] = this.species;
    return data;
  }
}

class Parent {
  int? id;
  String? name;
  String? slug;
  String? tdwgCode;
  int? tdwgLevel;
  int? speciesCount;
  Links? links;

  Parent({
    this.id,
    this.name,
    this.slug,
    this.tdwgCode,
    this.tdwgLevel,
    this.speciesCount,
    this.links,
  });

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    tdwgCode = json['tdwg_code'];
    tdwgLevel = json['tdwg_level'];
    speciesCount = json['species_count'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['tdwg_code'] = this.tdwgCode;
    data['tdwg_level'] = this.tdwgLevel;
    data['species_count'] = this.speciesCount;
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class Meta {
  int? total;

  Meta({this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total'] = this.total;
    return data;
  }
}
