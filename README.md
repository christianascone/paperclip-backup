# Paperclip::Backup

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'paperclip-backup'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install paperclip-backup

# Compatibility

Paperclip configured with storage on Amazon S3.


## Usage

### Enable backup for Paperclip attachment
```ruby
has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"                  
backup_attached_file :avatar
```

### Create migrations
```ruby
class AddPaperclipBackupColumns < ActiveRecord::Migration
  def change
    add_column :photos, :image_last_backup_at, :datetime
    add_column :photos, :image_backup_archives, :string, array: true, default: []
  end
end
```

### Launch backup of all models
```ruby
Paperclip::Backup.backup_all_models!
```

### Launch backup for a single Paperclip attachment


### config/initializers/paperclip-backup.rb

```ruby
Paperclip::Backup.configuration do |config|
  config.run_at = ''
end
```


## Contributing

1. Fork it ( https://github.com/micred/paperclip-backup/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
