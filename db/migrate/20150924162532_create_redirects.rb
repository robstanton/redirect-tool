class CreateRedirects < ActiveRecord::Migration
  def change
    create_table :redirects do |t|
      t.string :source
      t.string :target
      t.string :changedby
      t.boolean :published

      t.timestamps null: false
    end
  end
end
