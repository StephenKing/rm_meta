module MetaHelper

    def meta_description(*args)
        RAILS_DEFAULT_LOGGER.info " >>> #{args.inspect}" # FIXME
        if args.empty?
            if @meta_description
                @meta_description
            else
                Redmine::Info.app_name
            end
        else
            @meta_description = args
        end
    end

    def meta_keywords(*args) # FIXME: should be a way to clear
        if args.empty?
            @meta_keywords = %w(issue bug tracker) if @meta_keywords.blank?
            @meta_keywords.select {|k| !k.blank? }.join(',')
        else
            @meta_keywords ||= []
            @meta_keywords += args
        end
    end

    def extract_keywords(text)
        text.scan(%r{[^\000-\100\133-\140\173-]{4,30}}i).inject({}) { |hash, word|
            keyword = word.downcase
            if hash.has_key?(keyword)
                hash[keyword] += 1
            else
                hash[keyword] = 1
            end
            hash
        }.sort{ |a, b| b[1] <=> a[1] }.collect{ |item| item[0] }.first(10)
    end

end
