class RenameJobColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :jobs, :lower_upper_bound, :wage_lower_bound
  end
end
