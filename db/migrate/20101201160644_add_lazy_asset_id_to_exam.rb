# -*- encoding : utf-8 -*-
class AddLazyAssetIdToExam < ActiveRecord::Migration
  def self.up
    add_column :exams, :lazy_asset_id, :integer
  end

  def self.down
    remove_column :exams, :lazy_asset_id
  end
end
