class CreateRedirects < ActiveRecord::Migration
  def change
    create_table :redirects do |t|
      t.string :source, null: false
      t.string :target, null: false
      t.string :changedby, null: false
      t.boolean :published, default: false, null: false

      t.timestamps null: false
    end
  end
end
