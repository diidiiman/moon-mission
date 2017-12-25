class AddTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.text :tweet
      t.string :keywords

      t.timestamps
    end

    add_reference :tweets, :token, :index => true, :foreign_key => true
  end
end
