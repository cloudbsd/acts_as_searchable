require 'active_record'
require 'acts_as_searchable/adapter'

module ActsAsSearchable
  module Search
    extend ActiveSupport::Concern
  # include Adapter

    self.included do
      extend Adapter
    end

    module ClassMethods
      def search(value)
        conditions = []
        self.searchable_fields.each do |field|
          sql_like, sql_value = sql_query_parameters(value)
          conditions << "#{self.table_name}.#{field.to_s} #{sql_like} '#{sql_value}'"
        end
        return self.where(conditions.join(' OR '))
      end
    end # module ClassMethods
  end # module Search
end # module ActsAsSearchable

module ActsAsSearchable
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def acts_as_searchable(*fields)
      class_attribute :searchable_fields
      rails "Please specify the fields to search on" if fields.empty?
      self.searchable_fields = fields
      include ActsAsSearchable::Search
    end
  end
end

ActiveRecord::Base.send(:include, ActsAsSearchable)


=begin
module ActsAsSearchable
  def acts_as_searchable(*fields)
  # class_inheritable_accessor :searchable_fields
    class_attribute :searchable_fields
    rails "Please specify the fields to search on" if fields.empty?
    self.searchable_fields = fields
  end

  def search(value)
    conditions = []
    self.searchable_fields.each do |field|
      if using_postgresql?
      # where("title @@ :q or body @@ :q", q: query)
      # where("title ilike :q or body ilike :q", q: "%#{query}%")
      # conditions << "#{self.table_name}.#{field.to_s} ILIKE '%#{value}%'"
        conditions << "#{self.table_name}.#{field.to_s} @@ '#{value}'"
      else
        conditions << "#{self.table_name}.#{field.to_s} LIKE '%#{value}%'"
      end
    end
    return self.where(conditions.join(' OR '))
  end
end

ActiveRecord::Base.send(:extend, ActsAsSearchable)
=end
