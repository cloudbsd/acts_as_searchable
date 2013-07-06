require 'test_helper'

$stdout = StringIO.new

def create_properties_table
  ActiveRecord::Schema.define(:version => 1) do
    create_table :properties do |t|
      t.string :name
      t.text :body
    end
  end
end

class Property < ActiveRecord::Base
  acts_as_searchable :name, :body
end

class ActsAsSearchableTest < ActiveSupport::TestCase
  setup do
    create_properties_table
    Property.create(name: 'first name', body: 'first body')
    Property.create(name: 'second name', body: 'just body')
  end

  test "truth" do
    assert_kind_of Module, ActsAsSearchable
  end

  test 'search method is available' do
    assert Property.respond_to?(:search)
  end

  test "search method works" do
    assert_equal 2, Property.search('name').size
    assert_equal 2, Property.search('body').size
    assert_equal 1, Property.search('first').size
    assert_equal 1, Property.search('second').size
    assert_equal 0, Property.search('zero').size
  end

  test "post model works" do
    Post.create(title: 'first name', body: 'first body')
    Post.create(title: 'second name', body: 'just body')
    assert_equal 2, Post.search('name').size
    assert_equal 2, Post.search('body').size
    assert_equal 1, Post.search('first').size
    assert_equal 1, Post.search('second').size
    assert_equal 0, Post.search('zero').size
  end
end
