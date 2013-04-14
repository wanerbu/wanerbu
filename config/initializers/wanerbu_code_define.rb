# encoding: utf-8

module Wanerbu
  module Common
    FORMAT_PASSWORD = /\A[a-zA-Z0-9]+\z/
    FORMAT_LOGIN_ID = /\A[a-zA-Z0-9]+\z/
    FORMAT_TELEPHONE = /\A[0-9]+\z/

    NUMBER_PER_PAGE = 10
  end

  module CodeDefine
    ADMIN_STATUS = {
      # 活跃
      active: '00',
      # 锁定
      locked: '01' 
    }
    GYM_STATUS = {
      # 草稿
      draft: '00',
      # 审核中
      applying: '01',
      # 审核通过
      applied: '02',
      # 撤消
      canceled: '99'
    }
  end
end

