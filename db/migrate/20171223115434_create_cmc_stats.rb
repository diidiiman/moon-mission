class CreateCmcStats < ActiveRecord::Migration[5.1]
  def change
    create_table :cmc_stats do |t|
      t.integer :rank
      t.decimal :price_usd, :precision => 20, :scale => 8
      t.decimal :price_btc, :precision => 20, :scale => 8
      t.decimal :market_cap_usd, :precision => 20, :scale => 8
      t.decimal :daily_volume, :precision => 20, :scale => 8
      t.decimal :percent_change_1h, :precision => 20, :scale => 8
      t.decimal :percent_change_24h, :precision => 20, :scale => 8
      t.decimal :percent_change_7d, :precision => 20, :scale => 8

      t.timestamps
    end

    add_reference :cmc_stats, :token, :index => true, :foreign_key => true
  end
end
