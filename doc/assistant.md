Assistant Api
=====

#### POST /login(.:format)  

Login by mobile and password.

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
data[mobile] | true | Integer | 
data[password] | true | String | 

-----

#### GET /current_user(.:format)  

Display the current login user's details.

-----

#### GET /vip_card_orders(.:format)  

Display all vip card orders' informations of current login dealer.

-----

#### GET /vip_card_orders/:id(.:format)  

Display specified vip card order's details.

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  

-----

#### POST /vip_card_orders/search(.:format)  

Search vip card orders by mobile and plate_num.

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
query | true | String | 

-----

#### POST /vip_card_orders/:id/use(.:format)  

设置会员卡订单使用次数

> 例如：
> ```
> POST /assistant/vip_card_orders/1/use
> data[1]   1
> data[2]   2
> ```


Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  
data | true | Hash | key为会员卡订单服务项目ID，value为使用次数

-----

#### GET /operating_records(.:format)  

Display all operating records' informations of current login dealer.

-----

#### GET /operating_records/:id(.:format)  

Display specified operating record's details.

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  

-----

#### POST /operating_records(.:format)  

Create a new operating record.

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
data[user_brand] | false | String | 车型
data[user_plate_num] | true | String | 车牌号
data[project] | true | String | 施工项目
data[operator] | false | String | 施工人员
data[inspector] | false | String | 质检员
data[adviser] | true | String | 服务顾问

-----
