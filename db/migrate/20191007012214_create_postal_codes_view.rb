class CreatePostalCodesView < ActiveRecord::Migration[5.2]
  def up
    self.connection.execute %Q( CREATE OR REPLACE VIEW post_codes AS
      SELECT
          r.postal_code AS post_code,
          COUNT(*) AS total_places,
          SUM(r.number_of_chairs) AS total_chairs,
          TRUNC(((SUM(r.number_of_chairs) / ((SELECT SUM(number_of_chairs::decimal) FROM restaurants) - SUM(r.number_of_chairs::decimal))) * 100), 2) AS chairs_pct,
          (SELECT name FROM restaurants rr WHERE r.postal_code = rr.postal_code AND MAX(r.number_of_chairs) = rr.number_of_chairs) AS place_with_max_chairs,
          MAX(r.number_of_chairs) AS max_chairs
        FROM restaurants r
        GROUP BY r.postal_code;)
  end

  def down
    self.connection.execute "DROP VIEW IF EXISTS post_codes;"
  end
end
