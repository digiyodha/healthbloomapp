class DeleteMemberRequest {
  DeleteMemberRequest({
    this.familyMemberId,
  });

  String familyMemberId;

  factory DeleteMemberRequest.fromJson(Map<String, dynamic> json) =>
      DeleteMemberRequest(
        familyMemberId:
            json["family_member_id"] == null ? null : json["family_member_id"],
      );

  Map<String, dynamic> toJson() => {
        "family_member_id": familyMemberId == null ? null : familyMemberId,
      };
}
