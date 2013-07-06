class Post < ActiveRecord::Base
  acts_as_searchable :title, :body
end
