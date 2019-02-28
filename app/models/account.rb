class Account < ApplicationRecord
    belongs_to :shop
    validates :variant_id, presence: true
    validates :product, presence: true
    


    def self.totals_by_year_month
        find_by_sql(<<-SQL
          SELECT
            date_trunc('month', created_at) AS year_month,
            count(id) as amount
          FROM accounts
          GROUP BY year_month
          ORDER BY year_month, amount
          SQL
        ).map do |row|
          [
            row['year_month'].strftime("%B %Y"),
            row.amount.to_f,
          ]
        end
      end

      def self.variant_by_year_month(id)
        find_by_sql(<<-SQL
          SELECT
            variant_id as variant,
            count(variant_id) as total_variant
          FROM accounts
          WHERE shop_id=#{id}
          GROUP BY variant
          ORDER BY variant
          SQL
        ).map do |row|
          [
            row.variant,
            row.total_variant,
          ]
        end
      end


      def self.shop_by_year_month(store_id)
        find_by_sql(<<-SQL
          SELECT
            date_trunc('month', created_at) AS year_month,
            count(id) as amount
          FROM accounts a
          WHERE shop_id=#{store_id}
          GROUP BY year_month
          ORDER BY year_month, amount
          SQL
        ).map do |row|
          [
            row['year_month'].strftime("%B %Y"),
            row.amount.to_f,
          ]
        end
      end
end
