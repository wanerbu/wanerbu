## Tips(一些项目常用的参照)

* 定制了formtastic标签的路径:  app/inputs/  
* 系统用户左边栏菜单的配置文件路径:  config/admin_navigation.rb
* 普通用户左边栏菜单的配置文件路径:  config/user_navigation.rb
* 系统用户的权限配置文件:  app\models\admin_ability.rb
* enum code define文件的路径:  config\initializers\wanerbu_code_define.rb
* 对分页组件的重写，主要是调整了使用标签:  config\initializers\pagination_list_link_render.rb , 同时在application helper中重写了以下helper:
```ruby
  # change the default link renderer for will_paginate
  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end
    unless options[:renderer]
      options = options.merge :renderer => PaginationListLinkRenderer
    end
    super *[collection_or_options, options].compact
  end
```


## CSS编码规范

参照： https://github.com/necolas/idiomatic-css/tree/master/translations/zh-CN

特别摘出：

#### 声明顺序例子

```css
.selector {
  position: relative;
  display: block;
  float: left;
  width: 50%;
  height: 100px;
  padding: 10px;
  border: 0;
  margin: 10px;
  color: #fff
  background: #000;
}
```

## 本次CSS目录组织的说明

#### 由以下文件组成  
  * application.css: 记录所用网页都要用到的css
  * admin.css: 记录后台用到的通用css
  * user.css: 记录前台要用到的通用css  
  
  `以上三个里面都只是require其他文件，并不会写真正的css样式在文件里`

  * common.css: 记录前后台通用的css，主要记录组件部分，被application.css引用
  * _base.css: 记录前后台通用的css, 主要记录Base部分，比如一些通用的变量等，被common.css引用

#### 本次css的分层  
  
  * Base: 这个是基本的一些变量，以及样式，比如wb-clear-left等，不涉及组件样式部分, 主要被组件，以及专用页面样式引用
  * Common: 这里主要记录通用组件的一些样式，比如翻页组件，比如datagrid组件等
  * 专用页面： 这里就是每个页面专用的css样式，可能比较多的是以id选择器为住

#### 命名
  
  * 所有我们的样式都以  wb- 开头
  * 采用 XX-XXX-XXX 的格式


## 关于Helper的说明

* 本次开发中，默认不为controller加载所有的helper，这样的话，每个controller只有自己对应的helper，以及父类对应的helper中的方法可用。  
* 这样，所有通用的helper写到application_helper中，所有admin通用的helper写到admin_base_helper中，user通用的helper写到user_base_helper中。  
* 如果将来helper太多，可以把同类的抽出来，然后放到module中。

## 关于逻辑删除的说明

本次逻辑删除使用如下gem实现:
https://github.com/goncalossilva/rails3_acts_as_paranoid  

#### 常用的filter:  

```ruby
Admin.only_deleted # retrieves the deleted records
Admin.with_deleted # retrieves all records, deleted or not
```
#### 如果使用的是deleted_at标志位的话，还可以使用如下filter:(我们这次使用的就是deleted_at标志位)  
```ruby
time = Time.now
Admin.deleted_after_time(time)
Admin.deleted_before_time(time)
# Or roll it all up and get a nice window:
Admin.deleted_inside_time_window(time, 2.minutes)
```
#### 逻辑删除代码:  
```ruby
@admin.destroy
or (未验证)
Admin.destroy(params[:id])
```
#### 物理删除代码:  
```ruby
@admin.destroy!
or (未验证)
Admin.destroy!(params[:id])
or
Admin.delete_all!(conditions)
```
## 关于Enum枚举的说明

参考网站:  https://github.com/brainspec/enumerize  
(一定要看这个网站，要知道提供了哪些方便的方法。)  

本次开发I18n文件的路径:  `/wanerbu/config/locales/enumerize/enumerize.zh-CN.yml`  

Code定义文件的路径:  `/wanerbu/config/initializers/wanerbu_code_define.rb`  

#### 得到对应的I18n字符串  
```ruby
@admin.status.text
or
@admin.status_text
```
#### 判断enum属性值的方法
```ruby
@admin.status_active?
```

## 关于菜单的做成

菜单使用了simple-navigation组件，参照:  https://github.com/andi/simple-navigation  

本次菜单主要分三部分:

1. 顶部固定菜单
2. 左边主菜单
3. 右边主内容区的顶部菜单（主要是针对某个大功能的二级功能菜单）  

其中前两个菜单通过simple-navigation实现。  
目前后台管理员的左边主菜单使用配置文件路径:  config/admin_navigation.rb  
目前前台用户的左边主菜单使用配置文件路径:  config/user_navigation.rb  

#### 关于第三类菜单的实现

主要知道有一个公用的render，路径在: app/views/common_parts/_sub_menu_end.html.erb  
这个文件里面就只有一个 `</ul>` 结束符号，之所以这样是要实现动态菜单，比如像 _*master详细*_ ，
_*master编辑*_ 等菜单, 因为像 _*master一览*_ 这些菜单, 应该是固定菜单，所以单独写在一个
render文件中，但是又不能直接把关闭ul的代码写到同一个文件中，这样就实现不了动态了。

## 关于权限的控制

本次权限控制使用了cancan组件，参照:  https://github.com/ryanb/cancan

系统用户的权限配置路径:  app/models/admin_ability.rb  
所有机能的定义: app/models/function.rb  

#### 开发一个机能后的权限相关配置

1. 首先在function.rb中注册这个机能
2. 在admin_ability或者user_ability中配置可以访问这个机能的权限
3. 通过在controller中加入  `load_and_authorize_resource`  可以为每一个action加上权限控制，具体使用可以参照cancan guide。

#### 如何定制使用自己的ability文件

cancan默认使用current_user来获得当前的用户，可以通过在controller定义以下方法来自定义

```ruby
  ## 定义登录管理员的权限
  def current_ability
    @current_ability ||= AdminAbility.new(current_admin)
  end
```
#### 在view中的使用示例

```ruby
    <% if can? :update, @admin %>
```
#### 在navigation中的使用示例

```ruby
    primary.item :admins, I18n.t('admin.nav.main_menu.common.management', model: Admin.model_name.human),
      admin_master_admin_reports_path, { if: Proc.new { current_admin && current_admin.ability?(:manage_admin) },
      :class => 'nav-header'} do |sub_nav|
```



