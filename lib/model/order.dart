class Order {

  /**
   * email : "john@example.com"
   * name : "John Smith"
   * mother : {"email":"alice@example.com","name":"Alice"}
   * friends : [{"email":"Jack@example.com","name":"Jack"},{"email":"Nancy@example.com","name":"Nancy"}]
   */

  String email;
  String name;
  MotherBean mother;
  List<FriendsListBean> friends;

  static Order fromMap(Map<String, dynamic> map) {
    Order order = new Order();
    order.email = map['email'];
    order.name = map['name'];
    order.mother = MotherBean.fromMap(map['mother']);
    order.friends = FriendsListBean.fromMapList(map['friends']);
    return order;
  }

  static List<Order> fromMapList(dynamic mapList) {
    List<Order> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class MotherBean {

  /**
   * email : "alice@example.com"
   * name : "Alice"
   */

  String email;
  String name;

  static MotherBean fromMap(Map<String, dynamic> map) {
    MotherBean motherBean = new MotherBean();
    motherBean.email = map['email'];
    motherBean.name = map['name'];
    return motherBean;
  }

  static List<MotherBean> fromMapList(dynamic mapList) {
    List<MotherBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class FriendsListBean {

  /**
   * email : "Jack@example.com"
   * name : "Jack"
   */

  String email;
  String name;

  static FriendsListBean fromMap(Map<String, dynamic> map) {
    FriendsListBean friendsListBean = new FriendsListBean();
    friendsListBean.email = map['email'];
    friendsListBean.name = map['name'];
    return friendsListBean;
  }

  static List<FriendsListBean> fromMapList(dynamic mapList) {
    List<FriendsListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
