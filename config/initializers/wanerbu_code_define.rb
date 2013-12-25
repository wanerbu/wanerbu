# encoding: utf-8

module Wanerbu
  module Common
    FORMAT_PASSWORD = /\A[a-zA-Z0-9]+\z/
    FORMAT_LOGIN_ID = /\A[a-zA-Z0-9]+\z/
    FORMAT_TELEPHONE = /\A[0-9]+\z/

    NUMBER_PER_PAGE = 3
    AUTO_GENERATE_PASSWORD_LENGTH = 8
    GYM_MANAGER_ROLE_ID = 3
   #两次提交评论的间隔秒限制 
    COMMENT_LIMIT_SECOND = 60
   #订单支付时间分钟限制
    PAY_ORDER_LIMIT_MINUTE = 1
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

    #场地预订类型
    COURT_RESERVATION_TYPE = {
      # 按时间
      according_time: '00',
      # 按人次
      according_people: '01' 
    }
  end
end

