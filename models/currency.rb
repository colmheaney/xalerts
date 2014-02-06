# encoding: UTF-8
class Currency
  include DataMapper::Resource

  property :id,               Serial
  property :symbol,           String
end
