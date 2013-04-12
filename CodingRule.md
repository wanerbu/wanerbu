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



















