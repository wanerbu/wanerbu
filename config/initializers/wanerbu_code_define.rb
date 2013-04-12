# encoding: utf-8

module Wanerbu
  module Common
    FORMAT_PASSWORD = /\A[a-zA-Z0-9]+\z/
    FORMAT_LOGIN_ID = /\A[a-zA-Z0-9]+\z/
    FORMAT_TELEPHONE = /\A[0-9]+\z/
  end

  module CodeDefine
    ADMIN_STATUS = {
      # 活跃
      active: '00',
      # 锁定
      locked: '01' 
    }
  end
end

