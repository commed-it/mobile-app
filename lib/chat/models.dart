class ChatItemModel {
  final String idEncounter;
  final int idEnterprise;
  final String image;
  final String title;
  final String subtitle;

  ChatItemModel(this.idEncounter, this.idEnterprise, this.image, this.title, this.subtitle);
}

class ChatModel {
  final String idEncounter;
  final int idEnterprise;
  final String nameCompany;
  final String urlProfile;

  ChatModel(this.idEncounter, this.idEnterprise, this.nameCompany, this.urlProfile);

  factory ChatModel.init() {
    return ChatModel('', 1, '', '');
  }
}