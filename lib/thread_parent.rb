require 'thread_parent/version'
require 'thread'

module ThreadParent
  class Thread < Thread

    def initialize
      @_parent = Thread.current
      super
    end

    def parent
      @_parent
    end

    def [](key)
      if key?(key)
        super
      else
        parent[key]
      end
    end
  end
end
