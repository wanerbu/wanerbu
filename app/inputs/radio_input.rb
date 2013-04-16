# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
# 重写了formtastic的radioinput，主要是修改了生成的选项框的layout结构
# 没有用legend，而是和其他普通标签一样，用了label
class RadioInput < Formtastic::Inputs::RadioInput
  def to_html
    input_wrapping do
        label_html <<
        choices_group_wrapping do
          collection.map { |choice| 
            choice_wrapping(choice_wrapping_html_options(choice)) do
              choice_html(choice)
            end
          }.join("\n").html_safe
        end
    end
  end
end
