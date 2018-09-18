class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
       t.string :title
       t.text :content
       t.bigint :user_id
       t.index [:user_id], name:index_blogs_on_user_id
 
       t.timestamps
      
    end
  end
end
