class KeySet < Set
  def initialize(store, store_key)
    @store = store
    @store_key = store_key

    if existing = @store.send(:read_entry, @store_key, {})
      super(existing.value)
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

      def marshal_dump
        @hash
      end

      def marshal_load(obj)
        @hash = obj
      end
    end
  )

  private

  def store
    @store.send(:write_entry_without_match_support, @store_key, ActiveSupport::Cache::Entry.new(self), {})
  end
end
