API说明
==========

所有新建使用POST提交表单，修改使用PUT提交表单，删除使用DELETE，具体查看RESTful规范

PUT和DELETE可以使用POST模拟，需要额外添加_method=put/delete参数  
参数放在URL或放在表单里是等价的  
> 例如：PUT /api/current_user.json 等价于 POST /api/current_user.json?_method=put

成功返回success: true  
失败返回success: false, errors: [ 错误信息列表 ]

**注意：除了用户登录和新建用户外，所有API都需要加auth_token参数进行访问**  
> 例如：获取好友列表 GET /api/friends.json?auth_token=AuthToken  
> 其中，AuthToken在登录时返回

提交表单数据名称使用：data[字段名]  
> 例如：data[username]


User 用户
==========
字段
----------
:id, :username, :mobile, :avatar, :user_type（只读，手机端只能注册普通用户）, :description（用户说明，个性签名）, :detail

其中  
username是中文昵称  
user_type可能为 admin, user, dealer, provider  
detail是附加字段的 **哈希表**  

* 如果user_type是user，则detail包含以下附加字段  
  :sex, :area_id, :brand_id, :series, :plate_num（车牌号）, :balance（余额）, :reg_img（注册上传的汽车图片）, :area（根据area_id取得，string类型）, :brand（根据brand_id取得，string类型）

  Area和Brand，ID与名称对应表，见最后一章  
  提交表单时，area_id或area，brand_id或brand都可以使用，但不能同时使用area_id和area，brand_id和brand  
  > 例如：
  > 
  >     表单
  >     area       北京市
  > 
  > 和
  > 
  >     表单
  >     area_id    0
  > 
  > 是等价的

* 如果user_type是dealer，则detail包含以下附加字段  
  :dealer_type（服务商类型）, :company, :address, :phone, :open（开店时间）, :accepted（是否通过审核）, :balance, :reg_img（注册上传的资质证明图片）

* 如果user_type是provider，则detail包含以下附加字段  
  :company, :phone, :reg_img


**注意：为了安全，balance字段只读**


API
----------
Method | URI                               | 说明
-------|-----------------------------------|------------------------------------
GET    | /api/users/:id                    | 查询指定用户信息  
GET    | /api/users/:id/detail             | 查询指定用户详细信息  
GET    | /api/dealers                      | 查询所有商家信息  
GET    | /api/dealers/:id                  | 查询指定商家信息  
GET    | /api/dealers/:id/detail           | 查询指定商家详细信息  
GET    | /api/providers                    | 查询所有订阅号信息  
GET    | /api/providers/:id                | 查询指定订阅号信息  
GET    | /api/providers/:id/detail         | 查询指定订阅号详细信息  
POST   | /api/users/login                  | 用户登录  
POST   | /api/users                        | 新建用户，user_type默认为user  
GET    | /api/current_user                 | 查询当前用户信息  
GET    | /api/current_user/detail          | 查询当前用户详细信息  
PUT    | /api/current_user                 | 修改当前用户信息  
PUT    | /api/current_user/password        | 修改当前用户密码  

用户登录使用data[mobile]和data[password]进行登录，返回AuthToken和用户信息  
**注意：每次登陆会重新生成auth_token，原来auth_token的作废，但重新访问登陆接口前，auth_token一直有效，即使重设密码**

修改密码和修改用户信息接口基本一致，不过修改用户信息接口不能修改密码

修改密码需要提交data[current_password]和data[password]

> 例如：修改用户信息，state_msg和area_id字段，使用POST方式：  
> 
>     POST /api/current_user?auth_token=xxx
>     表单
>     _method                  put
>     data[state_msg]          xxx
>     data[detail][area_id]    1 

> 再例如：修改用户密码，使用POST方式：  
> 
>     POST /api/current_user/password?auth_token=xxx
>     表单
>     _method                  put
>     data[current_password]   xxx
>     data[password]           www 


Friend 好友
==========
API
----------
Method | URI                               | 说明
-------|-----------------------------------|------------------------------------
GET    | /api/users/:id/friends            | 查询指定用户好友信息  
GET    | /api/current_user/friends         | 查询当前用户好友信息  
GET    | /api/friends                      | （同上）  
POST   | /api/friends/:id                  | 添加好友  
DELETE | /api/friends/:id                  | 删除好友  

新建好友、删除好友只需POST、DELETE /api/current_user/friends/好友ID，不需要提交表单  


Post 圈子随手拍
==========
字段
----------
:content, :image  

API
----------
Method | URI                               | 说明
-------|-----------------------------------|------------------------------------
GET    | /api/users/:id/posts              | 查询指定用户发表的随手拍  
GET    | /api/current_user/posts           | 查询当前用户发表的随手拍  
GET    | /api/posts                        | 查询好友发表的随手拍  
GET    | /api/posts/friends                | （同上）  
GET    | /api/posts/top                    | 查询最热  
GET    | /api/posts/club                   | 查询车友会  
GET    | /api/posts/:id                    | 查询指定随手拍  
POST   | /api/posts                        | 新建随手拍  
DELETE | /api/posts/:id                    | 删除随手拍  

> 例如：  
> 
>     POST /api/posts
>     表单
>     data[content]    Hello


Comments 圈子随手拍评论
==========
字段
----------
:content  

API
----------
Method | URI                               | 说明
-------|-----------------------------------|------------------------------------
GET    | /api/posts/:post_id/comments      | 查询指定随手拍评论  
POST   | /api/posts/:post_id/comments      | 新建随手拍评论  
DELETE | /api/posts/:post_id/comments/:id  | 删除随手拍评论  

> 例如：  
> 
>     POST /api/posts/2/comments
>     表单
>     data[content]    Hello


Mending 保养专修
==========
字段
----------
:discount（哈希，优惠信息，哈希内的字段名待定）, :description, :mending_orders_count（保养专修订单数）  

API
----------
Method | URI                               | 说明
-------|-----------------------------------|------------------------------------
GET    | /api/tips/mendings                | 查询所有保养专修信息  
GET    | /api/tips/mendings/:id            | 查询指定保养专修信息  


Cleaning 洗车美容
==========
字段
----------
:title, :typehood（类型，因为我用的框架type是保留字，所以用了typehood）, :price（原价）, :vip_price（优惠价）, :description, :image, :cleaning_orders_count（洗车美容订单数）  

API
----------
Method | URI                               | 说明
-------|-----------------------------------|------------------------------------
GET    | /api/tips/cleanings               | 查询所有洗车美容信息  
GET    | /api/tips/cleanings/:id           | 查询指定洗车美容信息  


Activity 活动
==========
字段
----------
:title, :expire_at（过期时间）, :description, :image

API
----------
Method | URI                               | 说明
-------|-----------------------------------|------------------------------------
GET    | /api/tips/activities              | 查询所有活动信息  
GET    | /api/tips/activities/:id          | 查询指定活动信息  


BulkPurchasing 团购
==========
字段
----------
:title, :expire_at（过期时间）:typehood, :price（原价）, :vip_price（团购价）, :description, :image, :bulk_purchasing_orders_count（团购订单数）  

API
----------
Method | URI                               | 说明
-------|-----------------------------------|------------------------------------
GET    | /api/tips/bulk_purchasings        | 查询所有团购信息  
GET    | /api/tips/bulk_purchasings/:id    | 查询指定团购信息  


Order 订单
==========
字段
----------
:order_type（订单类型）, :detail  

其中  
user_type可能为 mending_order, cleaning_order, bulk_purchasing_order  
detail是附加字段的 **哈希表**  

* 如果user_type是mending_order，则detail包含以下附加字段  
  :price（只读，总价）, :brand_id, :plate_num（车牌号）, :arrive_at（到达时间）, :mending_type（专修类型）, :brand（根据brand_id取得，string类型）

* 如果user_type是cleaning_order，则detail包含以下附加字段  
  :price（只读，总价）, :count（购买数量）, :used_count（只读，已使用数量）

* 如果user_type是bulk_purchasing_order，则detail包含以下附加字段  
  :price（只读，总价）, :count（购买数量）

API
----------
Method | URI                                                               | 说明
-------|-------------------------------------------------------------------|------------------------
GET    | /api/tips/mendings/:mending_id/orders                             | 查询指定保养专修的所有订单  
GET    | /api/tips/mendings/:mending_id/orders/:id                         | 查询指定保养专修的指定订单  
POST   | /api/tips/mendings/:mending_id/orders                             | 新建指定保养专修订单  
PUT    | /api/tips/mendings/:mending_id/orders/:id/finish                  | 标记指定保养专修已完成  
PUT    | /api/tips/mendings/:mending_id/orders/:id/cancel                  | 标记指定保养专修已取消  
GET    | /api/tips/cleanings/:cleaning_id/orders                           | 查询指定洗车美容的所有订单  
GET    | /api/tips/cleanings/:cleaning_id/orders/:id                       | 查询指定洗车美容的指定订单  
POST   | /api/tips/cleanings/:cleaning_id/orders                           | 新建指定洗车美容订单  
PUT    | /api/tips/cleanings/:cleaning_id/orders/:id/use/:count            | 标记指定洗车美容已使用count次  
PUT    | /api/tips/cleanings/:cleaning_id/orders/:id/cancel                | 标记指定洗车美容已取消  
GET    | /api/tips/bulk_purchasings/:bulk_purchasing_id/orders             | 查询指定团购的所有订单  
GET    | /api/tips/bulk_purchasings/:bulk_purchasing_id/orders/:id         | 查询指定团购的指定订单  
POST   | /api/tips/bulk_purchasings/:bulk_purchasing_id/orders             | 新建指定团购订单  
PUT    | /api/tips/bulk_purchasings/:bulk_purchasing_id/orders/:id/finish  | 标记指定团购已完成  
PUT    | /api/tips/bulk_purchasings/:bulk_purchasing_id/orders/:id/cancel  | 标记指定团购已取消  
GET    | /api/dealers/:dealer_id/orders                                    | 查询指定商家的所有订单  
GET    | /api/dealers/:dealer_id/orders/:id                                | 查询指定商家的指定订单  


Review 订单评价
==========
字段
----------
:content, :stars（评价等级，几颗星）  

API
----------
Method | URI                                                               | 说明
-------|-------------------------------------------------------------------|------------------------
GET    | /api/tips/mendings/:mending_id/reviews                            | 查询指定保养专修的所有订单的评价  
POST   | /api/tips/mendings/:mending_id/orders/:id/review                  | 提交指定保养专修的指定订单的评价  
GET    | /api/tips/cleanings/:cleaning_id/reviews                          | 查询指定保养专修的所有订单的评价  
POST   | /api/tips/cleanings/:cleaning_id/orders/:id/review                | 提交指定保养专修的指定订单的评价  
GET    | /api/tips/bulk_purchasings/bulk_purchasing_id/reviews             | 查询指定保养专修的所有订单的评价  
POST   | /api/tips/bulk_purchasings/:bulk_purchasing_id/orders/:id/review  | 提交指定保养专修的指定订单的评价  
GET    | /api/dealers/:dealer_id/reviews                                   | 查询指定商家的所有订单的评价


Area对应表
==========

    [
      "北京市", "天津市", "上海市", "重庆市", "香港特别行政区", "澳门特别行政区", 
      "河北省", "山西省", "内蒙古自治区", "辽宁省", "吉林省", "黑龙江省", 
      "江苏省", "浙江省", "安徽省", "福建省", "江西省", "山东省", "河南省", 
      "湖北省", "湖南省", "广东省", "广西壮族自治区", "海南省", "四川省", 
      "贵州省", "云南省", "西藏自治区", "陕西省", "甘肃省", "青海省", 
      "宁夏回族自治区", "新疆维吾尔自治区", "台湾省",
    ]  

以0开头的数组，area_id是数字的index  


Brand对应表
==========
暂无  