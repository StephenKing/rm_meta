module MetaHelper

    def meta_description(*args)
        if args.empty?
            if @meta_description
                @meta_description
            else
                Redmine::Info.app_name
            end
        elsif args.first.is_a?(String)
            @meta_description = args.first.gsub(%r{\n+}, ' ')
        end
    end

    def meta_keywords(*args)
        if args.empty?
            @meta_keywords = %w(issue bug tracker) if @meta_keywords.blank?
            @meta_keywords.select {|k| !k.blank? }.join(',')
        elsif args.first.is_a?(Array)
            @meta_keywords = args.first
        else
            @meta_keywords ||= []
            @meta_keywords += args
        end
    end

    def meta_tag(name, *args)
        @meta ||= {}
        if args.empty?
            @meta.has_key?(name.to_s.downcase) ? @meta[name.to_s.downcase] : nil
        elsif args.first.blank?
            @meta.delete(name.to_s.downcase)
        else
            @meta[name.to_s.downcase] = args.first.to_s
        end
    end

    def meta_tags
        meta = ''
        if @meta
            @meta.each do |name, value|
                meta << yield(name, value) if block_given?
            end
            @meta.clear
        end
        meta.html_safe
    end

    def meta_description?
        if @meta_description
            true
        else
            false
        end
    end

    def meta_keywords?
        if @meta_keywords
            true
        else
            false
        end
    end

    def extract_keywords(text)
        strip_entities(text).scan(%r{[^\000-\100\133-\140\173-]{4,30}}i).inject({}) { |hash, word|
            keyword = word.downcase
            if hash.has_key?(keyword)
                hash[keyword] += 1
            else
                hash[keyword] = 1
            end
            hash
        }.sort{ |a, b| b[1] <=> a[1] }.collect{ |item| item[0] }.first(10)
    end

    def strip_textile(text, project = nil)
        text.gsub!(%r{\{\{[<>]?toc\}\}}i, '')
        plain = strip_tags(textilizable(text, :project => project))
        plain.gsub(%r{&(nbsp|para);}, ' ')
    end

    def strip_entities(text)
        text.gsub(%r{&#?[a-z0-9]+;}i, '')
    end

end
