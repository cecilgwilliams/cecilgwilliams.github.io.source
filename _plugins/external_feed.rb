require 'rss'
require 'open-uri'
require 'date'

module Jekyll
  class ExternalPostDisplay < Generator
    safe true
    priority :high
    def generate(site)
      jekyll_coll = Jekyll::Collection.new(site, 'external_feed')
      site.collections['external_feed'] = jekyll_coll
     
      url = "https://blogs.sourceallies.com/author/cwilliams/feed"

        open(url) do |rss|
            feed = RSS::Parser.parse(rss)
            feed.items.each do |item|
                title = item.title
                desc = item.description
                link = item.link
                pubdate = item.pubDate
                newdate = Date.parse(pubdate.to_s).strftime("%B %d, %Y")
                path = "./_external_feed/" + title + ".md"
                path = site.in_source_dir(path)
                doc = Jekyll::Document.new(path, { :site => site, :collection => jekyll_coll })
                doc.data['title'] = title
                doc.data['blog'] = "Source Allies Blog"
                doc.data['desc'] = desc
                doc.data['link'] = link
                doc.data['date'] = newdate
                jekyll_coll.docs << doc
            end
        end

    end
  end
end