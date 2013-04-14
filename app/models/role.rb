# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
# 系统角色
#
class Role < ActiveRecord::Base
  # function_codes中间的分隔符
  FUNCTION_CODES_SPLIT_CHAR = ','

  attr_accessible :function_codes, :name, :sort

  # 逻辑删除
  acts_as_paranoid

  ### validations
  validates :name,  :presence => true, on: :create
  validates :name, :length => { :in => 1..20 }, if: "name.present?", on: :create

  def functions
    self.function_codes.split(FUNCTION_CODES_SPLIT_CHAR).map do |f|
      Function::FUNCTIONS.find{|k,v| v[:code] == f}.first
    end
  end

end
