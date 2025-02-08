enum UserRole { user, admin, vendor }

UserRole getUserRole(String hash) {
  switch (hash) {
    case 'admin_hash':
      return UserRole.admin;
    case 'vendor_hash':
      return UserRole.vendor;
    default:
      return UserRole.user;
  }
}
