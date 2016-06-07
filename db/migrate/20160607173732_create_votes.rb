class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :concert, index: true, foreign_key: true
      t.references :song, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
