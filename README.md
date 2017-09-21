# Matrix Hack tool

## Run

```ruby
bundle
./hack_matrix.rb
```

## Test
```ruby
ruby -Itest test.rb
```

## Configuration

```ruby
matrix/config.rb

module Matrix
  module Config
    def default_config
      { url: 'https://challenge.distribusion.com/the_one/routes',
        passphrase: 'Kans4s-i$-g01ng-by3-bye' }
      end
    end
  end
end
```
