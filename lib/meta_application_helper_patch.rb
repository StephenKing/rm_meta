require_dependency 'application_helper'

module MetaApplicationHelperPatch

    def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
            unloadable

            alias_method_chain :textilizable, :meta
        end
    end

    module InstanceMethods

        META_RE = /^meta\(([^")]+)\)\. ?(.*?)(?:\r?\n(?:\r?\n)?|\Z)/m

        def textilizable_with_meta(*args)
            options = args.last.is_a?(Hash) ? args.pop : {}
            case args.size
            when 1
                object = options[:object]
                text = args.shift
            when 2
                object = args.shift
                method = args.shift
                text = object.send(method).to_s
            else
                raise ArgumentError, 'invalid arguments to textilizable'
            end

            text.gsub!(META_RE) do |match|
                name = $1.downcase
                case name
                when 'description'
                    description = $2.strip
                    unless description.empty?
                        meta_description(description)
                    end
                when 'keywords'
                    keywords = $2.strip.split(/\s*,\s*/)
                    unless keywords.empty?
                        meta_keywords(*keywords)
                    end
                else
                    value = $2.strip
                    unless value.empty?
                        meta_tag(name, value)
                    end
                end
                ''
            end

            html = textilizable_without_meta(text, options)

            content_for :header_tags do
                meta_tags do |name, value|
                    tag(:meta, :name => name, :content => value)
                end
            end

            html
        end

    end

end
