# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
#
class Admin::Master::AdminsController < Admin::AdminBaseController
  def index
    @admins = Admin.all
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end
end
