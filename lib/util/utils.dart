String getUsernameFromEmail(String? email) {
  if (email == null) return "Kanlas User";
  // Check if the email contains '@' character
  if (email.contains('@')) {
    String username = email.split('@')[0];
    // Capitalize the first letter of the username
    if (username.isNotEmpty) {
      return username[0].toUpperCase() + username.substring(1);
    } else {
      return username;
    }
  } else {
    // Return the original email if it doesn't contain '@'
    return email;
  }
}
