# encoding: utf-8

module Wanerbu
  module Common
    FORMAT_PASSWORD = /\A[a-zA-Z0-9]+\z/
    FORMAT_LOGIN_ID = /\A[a-zA-Z0-9]+\z/
    FORMAT_TELEPHONE = /\A[0-9]+\z/

    NUMBER_PER_PAGE = 10
    AUTO_GENERATE_PASSWORD_LENGTH = 8
    GYM_MANAGER_ROLE_ID = 3 
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
      # 撤消
      canceled: '02',
      # 审核通过
      approved: '03',
      # 拒绝
      rejected: '04',
      # 发布
      released: '05',
      # 暂停营业
      suspended: '06',
      # 锁定
      locked: '07' 
    }
  end
end

