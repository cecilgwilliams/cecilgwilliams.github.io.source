require 'rss'
require 'open-uri'
require 'date'

module Jekyll
  class ExternalPostDisplay < Generator
    safe true
    priority :high
    def generate(site)
      
        featured_feed = Jekyll::Collection.new(site, 'featured_feed')
        site.collections['featured_feed'] = featured_feed

        sai_feed = Jekyll::Collection.new(site, 'sai_feed')
        site.collections['sai_feed'] = sai_feed
        feed_url = "https://blogs.sourceallies.com/author/cwilliams/feed"
        featured_urls = [
        "https://blogs.sourceallies.com/2016/10/7-ways-to-go-beyond-agile/",
        "https://blogs.sourceallies.com/2014/06/updated-tdd-mantra/",
        "https://blogs.sourceallies.com/2013/12/a-better-analogy-for-agile-software-development/"
        ]
        open(feed_url) do |rss|
            feed = RSS::Parser.parse(rss)
            feed.items.each do |item|
                title = item.title
                desc = item.description
                link = item.link
                pubdate = item.pubDate
                newdate = Date.parse(pubdate.to_s).strftime("%B %d, %Y")
                
                if featured_urls.include?(link)
                    path = "./_featured_feed/" + title + ".md"
                    path = site.in_source_dir(path)
                    doc = Jekyll::Document.new(path, { :site => site, :collection => featured_feed })
                    doc.data['title'] = title
                    doc.data['blog'] = "Source Allies Blog"
                    doc.data['desc'] = desc
                    doc.data['link'] = link
                    doc.data['date'] = newdate
                    featured_feed.docs << doc
                else
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
        end

        cgw_feed = Jekyll::Collection.new(site, 'cgw_feed')
        site.collections['cgw_feed'] = cgw_feed
        feed_url = "https://cecilgwilliams.wordpress.com/feed"
        open(feed_url) do |rss|
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