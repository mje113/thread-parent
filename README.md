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

Thread is extended to provide direct access to its 'parent', or the thread where the current
thread was created.  It also provides a way to lookup through its ancestor chain for Thread-local variables.

```ruby
require 'thread_parent'

Thread.current[:abc] = 'abc'

Thread.new do |thread|
  
  thread.parent == Thread.main #=> true

  # Standard local variable lookup behaves as expected.
  thread[:abc] #=> nil

  # Lookup through the ancestor chain is now supported.
  thread.parents[:abc] #=> 'abc'

  # Local thread variable assignments works as expected.
  thread[:def] = 'def'
  thread[:def] #=> 'def'
  thread.parents[:def] #=> 'def' <- The calling thread is always checked first.

  # Short-hand references to the current thread's parents is also provided.
  Thread.parents[:abc] #=> 'abc'
  Thread.parent == Thread.main #=> true

  Thread.new do
    Thread.parents[:def] #= 'def'

    # The parent lookup will continue to the parent's parent until a variable is found.
    Thread.parents[:abc] #= 'abc'
  end
end
```

## Code Status

[![Build Status](https://api.travis-ci.org/mje113/thread-parent.png)](http://travis-ci.org/mje113/thread-parent)
[![Code Climate](https://codeclimate.com/github/mje113/thread-parent.png)](https://codeclimate.com/github/mje113/thread-parent)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
