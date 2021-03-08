class YoutubeUrlFormatter
  # iframe タグのsrc属性のURLを取得するための正規表現
  SRC_REGEX = /src\s*=\s*"([^"]*)"/
  # URL から動画IDを取得するための正規表現
  YOUTUBE_ID_REGEX = %r{\A(?:http(?:s)?://)?(?:www\.)?(?:m\.)?(?:youtu\.be/|youtube\.com/(?:(?:watch)?\?(?:.*&)?v(?:i)?=|(?:embed|v|vi|user)/))([^?&"'>]+)(&t=.*)?\z}

  def self.format(url)
    # YouTubeの埋め込み用iframeである場合はsrc属性のURLに置き換える
    src_match = SRC_REGEX.match(url)
    url = src_match[1] if src_match
    # YouTubeの動画である場合は埋め込み用URLを戻り値とする
    # そうでない場合はnilを返す
    youtube_id_match = YOUTUBE_ID_REGEX.match(url)
    if youtube_id_match
      "https://www.youtube.com/embed/#{youtube_id_match[1]}"
    end
  end
end