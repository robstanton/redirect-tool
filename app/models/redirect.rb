

class UriValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless valid_uri?(value)
      record.errors[attribute] << (options[:message] || 'is not a valid URI')
    end
  end
  private
  def valid_uri?(uri)
    URI.parse(uri)
    true
  rescue URI::InvalidURIError
    false
  end
end

class Redirect < ActiveRecord::Base

	validates :target, uri: true
end



