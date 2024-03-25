class Suffix {
  String msufix;
  String mDeptlst;

  Suffix({
    required this.msufix,
    required this.mDeptlst,
  });

  factory Suffix.fromJson(Map<String, dynamic> json) => Suffix(
    msufix: json["msufix"],
    mDeptlst: json["MDeptlst"],
  );

  Map<String, dynamic> toJson() => {
    "msufix": msufix,
    "MDeptlst": mDeptlst,
  };
}