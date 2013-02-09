# ThreadParent 

ThreadParent facilitates spawning threads that maintain a reference to the thread that created them.
The primary goal is to allow thread local variable lookup through the ancestor chain.

## Installation

Add this line to your application's Gemfile:

    gem 'thread-parent'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thread-parent

## Usage

You can either create ThreadParent::Thread directly:

```ruby
require 'thread-parent'

Thread.current[:abc] = 'abc'

ThreadParent::Thread.new do |thread|
  
  thread.parent == Thread.main #= true

  # Since the thread variable isn't set locally it will be found in its parent.
  Thread.current[:abc] #= 'abc'

  # Local thread variable assignments work as expected.
  Thread.current[:def] = 'def'

  ThreadParent::Thread.new do
    Thread.current[:def] #= 'def'

    # The parent lookup will continue to the parent's parent until a variable is found.
    Thread.current[:abc] #= 'abc'
  end
end
```

Or include the module to hijack references to Thread:

```ruby
require 'thread-parent'
include ThreadParent

Thread.new do
  # This is really a ThreadParent::Thread
end
```

## Code Status

[![Build Status](https://api.travis-ci.org/mje113/thread-parent.png)](http://travis-ci.org/mje113/thread-parent)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
