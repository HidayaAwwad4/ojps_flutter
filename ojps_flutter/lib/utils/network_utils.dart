String fixImageUrl(String url) {
  const localIp = '10.0.2.2';
  return url
      .replaceAll('127.0.0.1', localIp)
      .replaceAll('localhost', localIp);
}
