String getTimeAgo(String timestamp) {
  // Parse the timestamp
  DateTime parsedTime = DateTime.parse(timestamp).toUtc();
  DateTime currentTime = DateTime.now().toUtc();

  // Calculate the difference
  Duration difference = currentTime.difference(parsedTime);

  if (difference.inDays >= 365) {
    int years = (difference.inDays / 365).floor();
    return '$years year${years > 1 ? 's' : ''} ago';
  } else if (difference.inDays >= 30) {
    int months = (difference.inDays / 30).floor();
    return '$months month${months > 1 ? 's' : ''} ago';
  } else if (difference.inDays >= 1) {
    return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
  } else if (difference.inHours >= 1) {
    return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
  } else if (difference.inMinutes >= 1) {
    return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
  } else {
    return 'just now';
  }
}
