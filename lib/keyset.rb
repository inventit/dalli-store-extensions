require 'active_support/core_ext/module/aliasing'

class KeySet < Set
  def initialize(store, store_key)
    @store = store
    @store_key = store_key

    if existing = @store.send(:read_entry, @store_key, {})
      super(YAML.load(existing.to_s))
    else
      super([])
    end
  end

  alias add_without_cache add
  alias delete_without_cache delete
  alias clear_without_cache clear

  prepend(
    Module.new do
      def add(value)
        super(value)
      ensure
        store
      end

      def delete(value)
        super(value)
      ensure
        store
      end

      def clear
        super
      ensure
        store
      end
    end
  )

  private

  def store
    @store.send(:write_entry_without_match_support, @store_key, self.to_a.to_yaml, {})
  end
end
