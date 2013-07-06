module ActsAsSearchable
  module Adapter
  # extend ActiveSupport::Concern
  # included do
  #   private

  #   def self.using_postgresql?
  #     ::ActiveRecord::Base.connection && ::ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
  #   end
  # end

    private

    def sql_query_parameters(value)
      if using_postgresql?
        return '@@', value
      # return 'ILIKE', value
      else
        return 'LIKE', "%#{value}%"
      end
    end

    def using_postgresql?
      ::ActiveRecord::Base.connection && ::ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
    end

    def using_sqlite?
      ::ActiveRecord::Base.connection && ::ActiveRecord::Base.connection.adapter_name == 'SQLite'
    end

    def sha_prefix(string)
      Digest::SHA1.hexdigest("#{string}#{rand}")[0..6]
    end

    def like_operator
      using_postgresql? ? '@@' : 'LIKE'
    # using_postgresql? ? 'ILIKE' : 'LIKE'
    end

    # escape _ and % characters in strings, since these are wildcards in SQL.
    def escape_like(str)
      str.gsub(/[!%_]/){ |x| '!' + x }
    end
  end
end
