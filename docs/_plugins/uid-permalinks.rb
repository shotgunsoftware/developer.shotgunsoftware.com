

class PageUIDCollisionException < StandardError
  def initialize(msg="Page UID hashes collided.")
    super(msg)
  end
end

module Jekyll
    class Page
        def url=(name)
            @url = name
        end
    end

    class PermalinkRewriter < Jekyll::Generator
        safe true
        priority :low

        def generate(site)
            consumed_hashes = []
            site.pages.each do |item|
                if item.data["pagename"]
                    pagename = item.data["pagename"].to_s
                    if pagename == "index"
                        # Special caae for root index -- we want it to sit at /,
                        # not under a hash.
                        item.data["permalink"] = "/"
                        item.url = "/"
                    else
                        # Generate a hash from the pagename and truncate to 8
                        # characters for better usability.
                        uid = Digest::SHA1.hexdigest(pagename)[0..7]
                        # If hashes collide, raise an exception
                        if consumed_hashes.include? uid
                            raise PageUIDCollisionException.new
                        end
                        consumed_hashes << uid
                        # copy the site config permalink to modify
                        url = site.config["permalink"].dup
                        url = url.gsub! ":uid", uid
                        item.data["permalink"] = url
                        item.url = url
                    end
                end
            end
        end
    end
end
