class FiltersModel {
  final String? search;
  final String? sort;
  final bool? level;
  final int? take;
  final int? categoryId;

  FiltersModel(
      {this.search, this.sort, this.level, this.take, this.categoryId});

  FiltersModel copyWith(
      {String? search, String? sort, bool? level, int? take, int? categoryId}) {
    return FiltersModel(
        search: search ?? this.search,
        sort: sort ?? this.sort,
        level: level ?? this.level,
        take: take ?? this.take,
        categoryId: categoryId ?? this.categoryId);
  }

  FiltersModel clearCategoryId() => FiltersModel(
      search: search, sort: sort, level: level, take: take, categoryId: null);
}
