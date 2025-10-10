ActiveSupport.on_load(:before_initialize) do
  require 'keyset'

  module ActiveSupport
    module Cache
      class MemCacheStore < Store
        @@key = "delete_matched_support_key"

        alias write_entry_without_match_support write_entry
        alias clear_without_match_support clear
        alias delete_entry_with_match_support delete_entry

        prepend(
          Module.new do
            def write_entry(key, entry, options)
              keys.add(key)
              super(key, entry, options)
            end

            def clear(options=nil)
              keys.clear
              super(options)
            end

            def delete_entry(key, options)
              keys.delete(key)
              super(key, options)
            end
          end
        )

        def delete_matched(matcher, options=nil)
          keys.each do |key|
            delete_entry(key, options) if key =~ matcher
          end
        end

        def keys
          @keys ||= KeySet.new(self, @@key)
        end
      end
    end
  end
end
