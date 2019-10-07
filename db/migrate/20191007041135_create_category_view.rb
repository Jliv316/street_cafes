class CreateCategoryView < ActiveRecord::Migration[5.2]
  def up
    self.connection.execute %Q( CREATE OR REPLACE VIEW categories AS
      SELECT
          r.category,
          COUNT(*) AS total_places,
          SUM(r.number_of_chairs) AS total_chairs
        FROM restaurants r
        GROUP BY r.category;)
  end

  def down
    self.connection.execute "DROP VIEW IF EXISTS categories;"
  end
end
