export class AgUser {
  uid: String;
  photoUrl: String;
  phone: String;
  email: String;
  displayName: String;
  registerDate: String;
  lastLogin: String;

  constructor(uid: String = "", photoUrl: String = "", phone: String = "", email: String = "", displayName: String = "", registerDate: String = "", lastLogin: String = "") {
    this.uid = uid;
    this.photoUrl = photoUrl;
    this.phone = phone;
    this.email = email
    this.displayName = displayName;
    this.registerDate = registerDate;
    this.lastLogin = lastLogin;
  }

  getUid(): String {
    return this.uid;
  }

  getPhone(): String {
    return this.phone;
  }

  getEmail(): String {
    return this.email;
  }

  getDisplayName(): String {
    return this.displayName;
  }

  getPhotoUrl(): String {
    return this.photoUrl;
  }

  getRegisterDate(): String {
    return this.registerDate;
  }

  getLastLogin(): String {
    return this.lastLogin;
  }
}