require 'rss'
require 'open-uri'
require 'date'

module Jekyll
  class ExternalPostDisplay < Generator
    safe true
    priority :high
    def generate(site)
      
        sai_feed = Jekyll::Collection.new(site, 'sai_feed')
        site.collections['sai_feed'] = sai_feed
        url = "https://blogs.sourceallies.com/author/cwilliams/feed"
        open(url) do |rss|
            feed = RSS::Parser.parse(rss)
            feed.items.each do |item|
                title = item.title
                desc = item.description
                link = item.link
                pubdate = item.pubDate
                newdate = Date.parse(pubdate.to_s).strftime("%B %d, %Y")
                path = "./_sai_feed/" + title + ".md"
                path = site.in_source_dir(path)
                doc = Jekyll::Document.new(path, { :site => site, :collection => sai_feed })
                doc.data['title'] = title
                doc.data['blog'] = "Source Allies Blog"
                doc.data['desc'] = desc
                doc.data['link'] = link
                doc.data['date'] = newdate
                sai_feed.docs << doc
            end
        end

        cgw_feed = Jekyll::Collection.new(site, 'cgw_feed')
        site.collections['cgw_feed'] = cgw_feed
        url = "https://cecilgwilliams.wordpress.com/feed"
        open(url) do |rss|
            feed = RSS::Parser.parse(rss)
            feed.items.each do |item|
                title = item.title
                desc = item.description
                link = item.link
                pubdate = item.pubDate
                newdate = Date.parse(pubdate.to_s).strftime("%B %d, %Y")
                path = "./_cgw_feed/" + title + ".md"
                path = site.in_source_dir(path)
                doc = Jekyll::Document.new(path, { :site => site, :collection => cgw_feed })
                doc.data['title'] = title
                doc.data['blog'] = "Cecil G. Williams Blog"
                doc.data['desc'] = desc
                doc.data['link'] = link
                doc.data['date'] = newdate
                cgw_feed.docs << doc
            end
        end

    end
  end
end