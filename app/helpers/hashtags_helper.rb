module HashtagsHelper
  def display_hashtag(hashtag)
    "##{hashtag.name}"
  end

  def render_with_links(text)
    found_hashtags = text.scan(Hashtag::HASHTAG_REGEXP)

    found_hashtags.each do |found_hashtag|
      hashtag = Hashtag.find_by(name: found_hashtag.delete('#').downcase)

      text.gsub!(found_hashtag, link_to(found_hashtag, hashtag_path(hashtag)))
    end

    text
  end
end
