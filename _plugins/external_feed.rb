require 'rss'
require 'open-uri'

module Jekyll
  class ExternalPostDisplay < Generator
    safe true
    priority :high
    def generate(site)
      jekyll_coll = Jekyll::Collection.new(site, 'external_feed')
      site.collections['external_feed'] = jekyll_coll
     
      url = "https://blogs.sourceallies.com/author/cwilliams/feed"

        open(url) do |rss|
            # puts rss
            feed = RSS::Parser.parse(rss)
            puts "#{feed}"
            puts "Title: #{feed.channel.title}"
            feed.items.each do |item|
                puts "Item: #{item.title}"
                p "Title: #{item.title}, published on Source Allies Blog #{item.link} #{item}"
                title = item.title
                content = item.description
                guid = item.link
                path = "./_external_feed/" + title + ".md"
                path = site.in_source_dir(path)
                doc = Jekyll::Document.new(path, { :site => site, :collection => jekyll_coll })
                doc.data['title'] = title;
                doc.data['feed_content'] = content;
                jekyll_coll.docs << doc
            end
        end

    end
  end
end