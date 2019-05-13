

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
        # set priority to highest, since we're rewriting page URLs and other
        # plugins depend on these URLs during generation.
        priority :highest

        def generate(site)
            # We'll keep track of the consumed hashes so we can detect a
            # collision.
            consumed_hashes = []
            site.pages.each do |item|
                if item.data["pagename"]
                    # We'll generate UID urls for all pages with a pagename
                    # field in their slug.
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
                        # If hashes collide, raise an exception.
                        # The likelyhook of a collision with SHA1 truncated to
                        # 8 chars is very small...  If it becomes a problem we
                        # could do something here to deal with it, however it
                        # wouldn't be as simple as say shifting the windpow on
                        # the has, since existing URIs can't change when a new
                        # page is added that collides.
                        if consumed_hashes.include? uid
                            raise PageUIDCollisionException.new
                        end
                        consumed_hashes << uid
                        # Copy the site config permalink to use on this page,
                        # and replace the UID key with the generated UID.
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
