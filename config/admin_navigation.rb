# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify a custom renderer if needed.
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # The renderer can also be specified as option in the render_navigation call.
  # navigation.renderer = Your::Custom::Renderer

  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  navigation.selected_class = 'active'

  # Specify the class that will be applied to the current leaf of
  # active navigation items. Defaults to 'simple-navigation-active-leaf'
  # navigation.active_leaf_class = 'your_active_leaf_class'

  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false

  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # If you need to add custom html around item names, you can define a proc that will be called with the name you pass in to the navigation.
  # The example below shows how to wrap items spans.
  # navigation.name_generator = Proc.new {|name| "<span>#{name}</span>"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false

  # Define the primary navigation
  navigation.items do |primary|
    # Add an item to the primary navigation. The following params apply:
    # key - a symbol which uniquely defines your navigation item in the scope of the primary_navigation
    # name - will be displayed in the rendered navigation. This can also be a call to your I18n-framework.
    # url - the address that the generated item links to. You can also use url_helpers (named routes, restful routes helper, url_for etc.)
    # options - can be used to specify attributes that will be included in the rendered navigation item (e.g. id, class etc.)
    #           some special options that can be set:
    #           :if - Specifies a proc to call to determine if the item should
    #                 be rendered (e.g. <tt>:if => Proc.new { current_user.admin? }</tt>). The
    #                 proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :unless - Specifies a proc to call to determine if the item should not
    #                     be rendered (e.g. <tt>:unless => Proc.new { current_user.admin? }</tt>). The
    #                     proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :method - Specifies the http-method for the generated link - default is :get.
    #           :highlights_on - if autohighlighting is turned off and/or you want to explicitly specify
    #                            when the item should be highlighted, you can set a regexp which is matched
    #                            against the current URI.  You may also use a proc, or the symbol <tt>:subpath</tt>. 
    #
    primary.item :dashboard, I18n.t('admin.nav.main_menu.dashboard'), admin_dashboard_path, {:class => 'nav-header'}

    # 管理员管理菜单
    primary.item :admins, I18n.t('admin.nav.main_menu.common.management', model: Admin.model_name.human),
      admin_master_admin_reports_path, { if: Proc.new { current_admin && current_admin.ability?(:manage_admin) },
      :class => 'nav-header'} do |sub_nav|
        sub_nav.dom_class = 'nav nav-list'
        sub_nav.item :admins_list, I18n.t('admin.nav.main_menu.common.list', model: Admin.model_name.human), admin_master_admin_reports_path
        sub_nav.item :new_admin, I18n.t('admin.nav.main_menu.common.new', model: Admin.model_name.human), new_admin_master_admin_path
    end

    # 角色管理菜单
    primary.item :roles, I18n.t('admin.nav.main_menu.common.management', model: Role.model_name.human),
      admin_master_role_reports_path, { if: Proc.new { current_admin && current_admin.ability?(:manage_role) },
      :class => 'nav-header'} do |sub_nav|
        sub_nav.dom_class = 'nav nav-list'
        sub_nav.item :roles_list, I18n.t('admin.nav.main_menu.common.list', model: Role.model_name.human), admin_master_role_reports_path
        sub_nav.item :new_role, I18n.t('admin.nav.main_menu.common.new', model: Role.model_name.human), new_admin_master_role_path
    end

    #场馆相关master信息维护菜单
    primary.item :admins, I18n.t('admin.nav.main_menu.common.management', model: Gym.model_name.human),
      new_admin_master_attribute_path, {:class => 'nav-header'} do |sub_nav|
        sub_nav.dom_class = 'nav nav-list'
        #属性信息维护
        sub_nav.item :attributes_list, I18n.t('admin.nav.main_menu.common.list', model: Attribute.model_name.human), admin_master_attribute_reports_path
        sub_nav.item :new_attribute, I18n.t('admin.nav.main_menu.common.new', model: Attribute.model_name.human), new_admin_master_attribute_path
        #项目信息维护
        sub_nav.item :sports_list, I18n.t('admin.nav.main_menu.common.list', model: Sport.model_name.human), admin_master_sport_reports_path
        sub_nav.item :new_sport, I18n.t('admin.nav.main_menu.common.new', model: Sport.model_name.human), new_admin_master_sport_path
    end
    # You can also specify a condition-proc that needs to be fullfilled to display an item.
    # Conditions are part of the options. They are evaluated in the context of the views,
    # thus you can use all the methods and vars you have available in the views.
    # primary.item :key_3, 'Admin', url, :class => 'special', :if => Proc.new { current_user.admin? }
    # primary.item :key_4, 'Account', url, :unless => Proc.new { logged_in? }

    # you can also specify a css id or class to attach to this particular level
    # works for all levels of the menu
    # primary.dom_id = 'menu-id'
    primary.dom_class = 'nav nav-list'

    # You can turn off auto highlighting for a specific level
    # primary.auto_highlight = false
  end
end
