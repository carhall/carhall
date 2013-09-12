API说明
==========

请求使用的动词
----------
所有新建使用POST提交表单，修改使用PUT提交表单，删除使用DELETE，具体查看RESTful规范

GET、PUT和DELETE都可以使用POST模拟，需要额外添加_method=get/put/delete参数  
> 例如：
> 
>     PUT /api/current_user 
> 
> 等价于 
> 
>     POST /api/current_user 
>     表单
>     _method       put
> 

参数放在URL或放在表单里是等价的， **但_method是例外，必须放在POST表单中！**  

返回的结果
----------
成功返回success: true, data: 返回数据  
失败返回success: false, error: 错误信息, error_code: 错误类型，string类型

分页
---------
当data为数组的时候支持分页，方法是在GET请求的URI后加参数page（第几页）和per_page（每页显示多少个）  
> 例如：指每页显示5项，第2页，使用
> 
>     GET /api/posts?page=2&per_page=5

关于字段
----------
提交表单数据名称使用：data[字段名]  
> 例如：登录系统，使用
> 
>     POST /api/users/login
>     表单
>     data[mobie]       13323456787
>     data[password]    password

如果没有特殊说明，每章中的字段一节，就是创建，或编辑资源所需要提交的所有字段名  
而GET请求返回的资源，字段名也是这些，并包含一个ID，表示资源ID  
但要对于图片资源，例如字段名为image，上传时使用data[image]提交表单，但GET请求返回的资源中，字段名会变成image_url、image_medium_url和image_thumb_url，分别代表原始图片URL、中等尺寸图片URL和缩略图URL，缩略图暂定为60x60像素  

关于请求的URI
----------
每章中的API一节，给出的URI，例如：/api/users/:id/friends  
其中:id是一个变量，代表用户的ID，这里:id跟在users/后面，因此代表用户ID，同理posts/:id代表帖子的ID  
实际访问时，应该使用具体ID号代替:id，例如，要获取用户ID为1的用户的好友列表，应使用/api/users/1/friends  

**注意：除了用户登录和新建用户外，所有API都需要加auth_token参数进行访问**  
> 例如：获取好友列表 GET /api/friends ~~.json~~ ?auth_token=AuthToken  
> 其中，AuthToken在登录时返回

~~而请求以.json结尾，可以保证请求返回的数据格式为json，避免某些情况下出错打印HTML网页~~  
~~或者使用HTTP头，Accept: application/json，效果相同~~  
目前应该已经解决了API打印HTML的问题，因此不需要再使用以上手段  

User 用户
==========
字段
----------
字段名称         | 详细描述                    | 限制条件
----------------|----------------------------|----------------------------------
username        | 中文昵称                    | 2-20个字母或汉字，必须
mobile          |                            | 必须
avatar          | 头像                       | 上传时使用图片附件，查询返回数据为avatar_url，avatar_thumb_url，分别代表头像原图链接和头像缩略图链接
user_type       | 用户类型，可能为 admin（管理员）, user（普通用户）, dealer（汽车服务商）, provider（订阅号）| 只读，手机端只    能注册普通用户
description     | 用户说明，个性签名           |
detail          | 附加字段的 **哈希表**        |

* 如果user_type是user，则detail包含以下附加字段  
  
  字段名称           | 详细描述                    | 限制条件
  ------------------|----------------------------|--------------------------------
  detail[sex_id]    | 性别ID                     | 0或1，分别代表男或女
  detail[sex]       |                            | “男”或“女”中的一个汉字
  detail[area_id]   | 区域ID                     | area_id（integer）和area（string，根据area_id取得）指向同一个字段
  detail[area]      | 区域                       | 
  detail[brand_id]  | 品牌ID                     | 同area_id和area的关系
  detail[brand]     | 品牌                       | 
  detail[series]    | 型号                       |
  detail[plate_num] | 车牌号                     |
  detail[balance]   | 余额                       | 只读
  detail[car_image] | 注册上传的汽车图片           |

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
  > 是等价的,但是最好提交表单时用area_id和brand_id,数字更加简单方便.
  
  **注意：为了安全，balance字段只读**

* 如果user_type是dealer，则detail包含以下附加字段  

  字段名称                    | 详细描述                    | 限制条件
  ---------------------------|----------------------------|-----------------------
  detail[dealer_type_id]     | 服务商类型ID                | 0-3，对应洗车美容、专项服务、专修、4S店，同area_id和area的关系，见User关于area的说明
  detail[dealer_type]        | 服务商类型                  | 洗车美容、专项服务、专修、4S店，其中之一
  detail[business_scope_ids] | 业务范围IDs（数组）          | [0-8, 0-8, ...]，对应洗车、美容、轮胎、换油、改装、钣喷、空调、专修、保险，同area_id和area的关系，见User关于area的说明，唯一不同是这里是ID的数组
  detail[business_scopes]    | 业务范围（数组）             | 洗车、美容、轮胎、换油、改装、钣喷、空调、专修、保险，其中若干个
  detail[company]            |                            |
  detail[address]            |                            |
  detail[phone]              |                            |
  detail[open_during]        | 开店时间                    |

  **建议：显示时使用dealer_type和business_scopes，因为后期可能会添加新的业务范围**

* 如果user_type是provider，则detail包含以下附加字段  
  
  字段名称                 | 详细描述                    | 限制条件
  ------------------------|----------------------------|--------------------------
  detail[company]         |                            |
  detail[phone]           |                            |

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
POST   | /api/friends/:user_id             | 添加好友  
DELETE | /api/friends/:user_id             | 删除好友  

新建好友、删除好友只需POST、DELETE /api/friends/好友ID，不需要提交表单  


Blacklist 黑名单
==========
API
----------
Method | URI                               | 说明
-------|-----------------------------------|------------------------------------
GET    | /api/current_user/blacklists      | 查询当前用户好友信息  
GET    | /api/blacklists                   | （同上）  
POST   | /api/blacklists/:user_id          | 添加黑名单  
DELETE | /api/blacklists/:user_id          | 删除黑名单  

同好友接口一样，新建好友、删除黑名单只需POST、DELETE /api/blacklists/用户ID，不需要提交表单  
添加黑名单会删除好友关系，黑名单上的用户不能够被添加好友


Post 圈子随手拍
==========
字段
----------
字段名称         | 详细描述                    | 限制条件
----------------|----------------------------|----------------------------------
content         |                            | 必须
image           |                            |

API
----------
Method | URI                               | 说明
-------|-----------------------------------|------------------------------------
GET    | /api/users/:id/posts              | 查询指定用户发表的随手拍  
GET    | /api/current_user/posts           | 查询当前用户发表的随手拍  
GET    | /api/posts                        | （同上）  
GET    | /api/posts/friends                | 查询好友发表的随手拍  
GET    | /api/posts/top                    | 查询最热  
GET    | /api/posts/club                   | 查询车友会  
GET    | /api/posts/:id                    | 查询指定随手拍  
POST   | /api/posts                        | 新建随手拍  
DELETE | /api/posts/:id                    | 删除随手拍  
**注意：只有普通用户能访问该接口**    

> 例如：  
> 
>     POST /api/posts
>     表单
>     data[content]    Hello

GET查询车友会时，可以在URI中使用两个附加字段作为条件，filter[area_id]和filter[brand_id]来查询指定地区和品牌的帖子，，如果不填，默认返回用户所在的车友会信息（即根据用户的area_id, brand_id来查询），如果不填，默认返回用户所在的车友会帖子（即根据用户的area_id, brand_id来查询）  
> 例如：
> 
>     GET /api/posts/club?filter[area_id]=1&filter[brand_id]=2


Comments 圈子随手拍评论
==========
字段
----------
字段名称         | 详细描述                    | 限制条件
----------------|----------------------------|----------------------------------
content         |                            | 必须

API
----------
Method | URI                               | 说明
-------|-----------------------------------|------------------------------------
GET    | /api/posts/:post_id/comments      | 查询指定随手拍评论  
POST   | /api/posts/:post_id/comments      | 新建随手拍评论  
DELETE | /api/posts/:post_id/comments/:id  | 删除随手拍评论  
**注意：只有普通用户能访问该接口**    

> 例如：  
> 
>     POST /api/posts/2/comments
>     表单
>     data[content]    Hello


PostBlacklist 圈子黑名单
==========
API
----------
Method | URI                               | 说明
-------|-----------------------------------|------------------------------------
GET    | /api/current_user/post_blacklists | 查询当前用户好友信息  
GET    | /api/post_blacklists              | （同上）  
POST   | /api/post_blacklists/:user_id     | 添加黑名单  
DELETE | /api/post_blacklists/:user_id     | 删除黑名单  

**注意：只有普通用户能访问该接口**    

同好友接口一样，新建好友、删除圈子黑名单只需POST、DELETE /api/post_blacklists/用户ID，不需要提交表单  


Club 车友会
==========
字段
----------
字段名称         | 详细描述                    | 限制条件
----------------|----------------------------|----------------------------------
president_id    | 堂主ID                     | 只读
president       | 堂主                       | 只读
mechanic_ids    | 在线技师IDs                 | 只读
mechanics       | 在线技师                    | 只读
announcement    | 公告                       |
avatar          | LOGO                       |

API
----------
Method | URI                               | 说明
-------|-----------------------------------|------------------------------------
GET    | /api/current_user/club            | 查询当前用户所在车友会的信息  
GET    | /api/club                         | （同上）  
POST   | /api/club/president               | 申请成为车友会堂主  
POST   | /api/club/mechanics               | 申请成为车友会在线技师  
PUT    | /api/club                         | 修改车友会信息（包括公告和LOGO，只有堂主可用）  

**注意：只有普通用户能访问该接口**    

提交申请时需要带data[area_id]和data[brand_id]两个字段  
GET查询时，可以在URI中使用两个附加字段作为条件，filter[area_id]和filter[brand_id]来查询指定地区和品牌的车友会信息，如果不填，默认返回用户所在的车友会信息（即根据用户的area_id, brand_id来查询）  
> 例如：
> 
>     GET /api/club?filter[area_id]=1&filter[brand_id]=2


两种申请时，表单附加字段都为data[description]
修改车友会信息时，表单附加字段包括data[announcement]和data[avatar]，其他字段只读

Mending 保养专修
==========
字段
----------
字段名称              | 详细描述                    | 限制条件
---------------------|----------------------------|-----------------------------
discount             | 优惠信息                    | 返回哈希表，key是0-6，分别代表周日、周一到周六，value是优惠信息的哈希表，包含discount_during（优惠时段）、man_hours_discount（工时优惠）、spare_parts_discount（零件优惠）三个字段，例如：{0: {discount_during: '10:00 到 15:00', man_houts_discount: '7折'}, 6: {discount_during: '10:00 到 15:00', spare_parts_discount: '7折'}}
brand_ids            | 专修车型IDs                 |
brands               | 专修车型                    |
description          | 描述                       |
orders_count         | 保养专修订单数               |

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
字段名称              | 详细描述                    | 限制条件
---------------------|----------------------------|-----------------------------
title                |                            | 
cleaning_type_id     | 洗车美容类型ID              | 0-2
cleaning_type        | 洗车美容类型                | 洗车、漆面养护、清洁护理，其中之一
price                | 原价                       |
vip_price            | 会员价                      |
description          |                            |
image                |                            |
orders_count         | 洗车美容订单数               |

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
字段名称              | 详细描述                    | 限制条件
---------------------|----------------------------|-----------------------------
title                |                            | 
expire_at            | 过期时间                    |
description          |                            |
image                |                            |

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
字段名称                 | 详细描述                    | 限制条件
------------------------|----------------------------|--------------------------
title                   |                            | 
bulk_purchasing_type_id | 洗车美容类型ID              | 0-3
bulk_purchasing_type    | 洗车美容类型                | 洗车美容、保养专修、汽车装饰、其他，其中之一
expire_at               | 过期时间                    |
price                   | 原价                       |
vip_price               | 团购价                      |
description             |                            |
image                   |                            |
orders_count            | 团购订单数                  |

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
字段名称         | 详细描述                    | 限制条件
----------------|----------------------------|----------------------------------
title           |                            | 只读，由服务器端生成，例如：“美容洗车 1 份”
order_type      | 订单类型，可能为 mending_order, cleaning_order, bulk_purchasing_order | 只读，提交时通过不同的url区分订单类型
detail          | 附加字段的 **哈希表**        |

* 如果order_type是mending_order，则detail包含以下附加字段  
  
  字段名称             | 详细描述                    | 限制条件
  --------------------|----------------------------|--------------------------------
  detail[price]       | 总价                       | 只读，由服务器端计算得出
  detail[brand_id]    | 品牌ID                     | 
  detail[brand]       | 品牌                       | 
  detail[series]      | 型号                       |
  detail[plate_num]   | 车牌号                     |
  detail[arrive_at]   | 到达时间                    | 
  detail[description] | 预约项目                    |

* 如果order_type是cleaning_order，则detail包含以下附加字段  
  
  字段名称             | 详细描述                    | 限制条件
  --------------------|----------------------------|--------------------------------
  detail[price]       | 总价                       | 只读，由服务器端计算得出
  detail[count]       | 购买数量                    | 
  detail[used_count]  | 已使用数量                  | 只读，由服务器计算得出

* 如果order_type是bulk_purchasing_order，则detail包含以下附加字段  

  字段名称             | 详细描述                    | 限制条件
  --------------------|----------------------------|--------------------------------
  detail[price]       | 总价                       | 只读，由服务器端计算得出
  detail[count]       | 购买数量                    | 

API
----------
Method | URI                                                               | 说明
-------|-------------------------------------------------------------------|------------------------
GET    | /api/tips/mendings/:mending_id/orders                             | 查询指定保养专修的所有订单  
GET    | /api/tips/mendings/:mending_id/orders/:id                         | 查询指定保养专修的指定订单  
POST   | /api/tips/mendings/:mending_id/orders                             | 新建指定保养专修订单  
PUT    | /api/tips/mendings/:mending_id/orders/:id/finish                  | 标记指定保养专修已完成  
DELETE | /api/tips/mendings/:mending_id/orders/:id/cancel                  | 标记指定保养专修已取消  
GET    | /api/tips/cleanings/:cleaning_id/orders                           | 查询指定洗车美容的所有订单  
GET    | /api/tips/cleanings/:cleaning_id/orders/:id                       | 查询指定洗车美容的指定订单  
POST   | /api/tips/cleanings/:cleaning_id/orders                           | 新建指定洗车美容订单  
PUT    | /api/tips/cleanings/:cleaning_id/orders/:id/use/:count            | 标记指定洗车美容已使用count次  
DELETE | /api/tips/cleanings/:cleaning_id/orders/:id/cancel                | 标记指定洗车美容已取消  
GET    | /api/tips/bulk_purchasings/:bulk_purchasing_id/orders             | 查询指定团购的所有订单  
GET    | /api/tips/bulk_purchasings/:bulk_purchasing_id/orders/:id         | 查询指定团购的指定订单  
POST   | /api/tips/bulk_purchasings/:bulk_purchasing_id/orders             | 新建指定团购订单  
PUT    | /api/tips/bulk_purchasings/:bulk_purchasing_id/orders/:id/finish  | 标记指定团购已完成  
DELETE | /api/tips/bulk_purchasings/:bulk_purchasing_id/orders/:id/cancel  | 标记指定团购已取消  
GET    | /api/dealers/:dealer_id/orders                                    | 查询指定商家的所有订单  
GET    | /api/dealers/:dealer_id/orders/:id                                | 查询指定商家的指定订单  


Review 订单评价
==========
字段
----------
字段名称         | 详细描述                    | 限制条件
----------------|----------------------------|----------------------------------
content         |                            | 
stars           | 评价等级                    | 0-5

API
----------
Method | URI                                                               | 说明
-------|-------------------------------------------------------------------|------------------------
GET    | /api/tips/mendings/:mending_id/reviews                            | 查询指定保养专修的所有订单的评价  
POST   | /api/tips/mendings/:mending_id/orders/:id/review                  | 提交指定保养专修的指定订单的评价  
GET    | /api/tips/cleanings/:cleaning_id/reviews                          | 查询指定汽车美容的所有订单的评价  
POST   | /api/tips/cleanings/:cleaning_id/orders/:id/review                | 提交指定汽车美容的指定订单的评价  
GET    | /api/tips/bulk_purchasings/bulk_purchasing_id/reviews             | 查询指定团购的所有订单的评价  
POST   | /api/tips/bulk_purchasings/:bulk_purchasing_id/orders/:id/review  | 提交指定团购的指定订单的评价  
GET    | /api/dealers/:dealer_id/reviews                                   | 查询指定商家的所有订单的评价


常量表
==========
字段
----------

    sexes = ["男", "女"]
    areas = Area对应表
    brands = Brand对应表
    dealer_types = ["洗车美容", "专项服务", "专修", "4S店"]
    business_scopes = ["洗车", "美容", "轮胎", "换油", "改装", "钣喷", "空调", "专修", "保险"]
    cleaning_types = ["洗车", "漆面养护", "清洁护理"]
    bulk_purchasing_types = ["洗车美容", "保养专修", "汽车装饰", "其他"]

API
----------
提供一个API接口来查询服务器定义的常量  

Method | URI                               | 说明
-------|-----------------------------------|----------------------------------
GET    | /api/constants                    | 查询所有常量  
GET    | /api/constants/:constant_name     | 查询指定常量

其中，constant_name即为上表所列的常数名，小写
例如：获取所有的Area

    GET /api/constants/areas



Area对应表
----------

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
----------

    [
      "阿斯顿·马丁", "奥迪", "巴博斯", "宝骏", 
      "宝马", "保时捷", "北京汽车", "北汽威旺", "北汽制造", 
      "奔驰", "奔腾", "本田", "比亚迪", "标致", "别克", 
      "宾利", "布加迪", "昌河", "长安", "长安商用", "长城", 
      "DS", "大众", "道奇", "东风", "东风风度", "东风风神", 
      "东风小康", "东南", "法拉利", "菲亚特", "丰田", "风行", 
      "福迪", "福特", "福田", "GMC", "光冈", "广汽传祺", 
      "广汽吉奥", "哈飞", "哈弗", "海格", "海马", "悍马", 
      "恒天", "红旗", "华泰", "黄海", "Jeep", "吉利帝豪", 
      "吉利全球鹰", "吉利英伦", "江淮", "江铃", "捷豹", "金杯", 
      "金旅", "九龙", "卡尔森", "开瑞", "凯迪拉克", "科尼赛克", 
      "克莱斯勒", "兰博基尼", "劳伦士", "劳斯莱斯", "雷克萨斯", 
      "雷诺", "理念", "力帆", "莲花汽车", "猎豹汽车", "林肯", 
      "铃木", "陆风", "路虎", "路特斯", "MG", "MINI", 
      "马自达", "玛莎拉蒂", "迈凯伦", "摩根", "纳智捷", "讴歌", 
      "欧宝", "欧朗", "奇瑞", "启辰", "起亚", "日产", "荣威", 
      "如虎", "瑞麒", "SMART", "三菱", "陕汽通家", "上汽大通", 
      "绅宝", "世爵", "双环", "双龙", "思铭", "斯巴鲁", 
      "斯柯达", "威麟", "威兹曼", "沃尔沃", "五菱汽车", 
      "五十铃", "西雅特", "现代", "新凯", "雪佛兰", "雪铁龙", 
      "野马汽车", "一汽", "依维柯", "英菲尼迪", "永源", "中华", 
      "中兴", "众泰", "其它", 
    ]

以0开头的数组，brand_id是数字的index  


