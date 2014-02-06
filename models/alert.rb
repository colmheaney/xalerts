# encoding: UTF-8

class Alert
  include DataMapper::Resource

  property :id,               	Serial
  property :current_rate,   	Float,		:required => true
  property :upper_rate, 		Float,		:required => true
  property :lower_rate, 		Float,		:required => true
  property :symbol,				String,   	:required => true
  property :email,				String,		:required => true, :format => :email_address
  property :created_at,			DateTime
  property :updated_at, 		DateTime

end
