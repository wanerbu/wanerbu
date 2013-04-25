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
  validates :name, :presence => true, :uniqueness => true
  validates :name, :length => { :in => 1..20 }, if: "name.present?"

  ### DefaultScope
  default_scope order("sort ASC")

  def functions
    return [] if self.function_codes.blank?
    self.function_codes.split(FUNCTION_CODES_SPLIT_CHAR).map do |f|
      Function::FUNCTIONS.find{|k,v| v[:code] == f}.first
    end
  end

  def function_codes
    val = read_attribute(:function_codes)
    return val.nil? ? "" : val
  end

  def function_codes=(value)
    case value
      when Array
        write_attribute(:function_codes, value.select{|v| !v.blank?}.join(FUNCTION_CODES_SPLIT_CHAR))
      when String
        write_attribute(:function_codes, value)
      else
        write_attribute(:function_codes, nil)
    end
  end

  ## 当前角色是否拥有某个功能
  def has_function?(func)
    self.functions.any? {|f| func == f}
  end

  def function_names
    return [] if self.function_codes.blank?
    self.functions.map {|v| Function::FUNCTIONS[v][:name] }
  end

end
