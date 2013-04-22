# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
class Admin::WanerbuDeviseMailer < Devise::Mailer   
  # gives access to all helpers defined within `application_helper`.
  helper :application

  # TODO dairg define code
  default :from => "wanerbu@gmail.com"

  def welcome_admin(admin)
    @admin = admin
    # TODO dairg I18n
    mail(:to => @admin.email, :subject => "Welcome to My Awesome Site") do |format|
      format.html { render 'admin/admins/mailer/welcome_admin' }
    end
  end
end

