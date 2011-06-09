require_dependency 'application_helper'

module MetaApplicationHelperPatch

    def self.included(base)
        base.class_eval do

            def meta_description(*args)
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

            def meta_keywords(*args)
                if args.empty?
                    @meta_keywords = %w(issue bug tracker) if @meta_keywords.blank?
                    @meta_keywords.select {|k| !k.blank? }.join(',')
                else
                    @meta_keywords ||= []
                    @meta_keywords += args
                end
            end

        end
    end

end
