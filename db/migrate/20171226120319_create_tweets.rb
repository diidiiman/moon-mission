class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :day_tweets do |t|
      t.integer :tw_id, :length => 20

      t.timestamps
    end

    add_reference :day_tweets, :token, :index => true, :foreign_key => true
  end
end
