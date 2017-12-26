class CreateTweetStats < ActiveRecord::Migration[5.1]
  def change
    create_table :tweet_stats do |t|
      t.integer :count, :default => 0
      t.datetime :date
    end

    add_reference :tweet_stats, :token, :index => true, :foreign_key => true
  end
end
