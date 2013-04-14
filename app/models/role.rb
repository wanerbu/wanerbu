# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
# 系统角色
#
class Role < ActiveRecord::Base
  attr_accessible :functions, :name, :sort

  # 逻辑删除
  acts_as_paranoid

  ### validations
  validates :name,  :presence => true, on: :create
  validates :name, :length => { :in => 1..20 }, if: "name.present?", on: :create
end
