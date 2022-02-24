class GetMemberRequest {
  GetMemberRequest({
    this.familyMemberId,
  });

  String familyMemberId;

  factory GetMemberRequest.fromJson(Map<String, dynamic> json) =>
      GetMemberRequest(
        familyMemberId:
            json["family_member_id"] == null ? null : json["family_member_id"],
      );

  Map<String, dynamic> toJson() => {
        "family_member_id": familyMemberId == null ? null : familyMemberId,
      };
}
