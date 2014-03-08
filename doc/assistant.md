Assistant Api
=====

#### POST /assistant/login(.:format)  

Login by mobile and password.

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
data[mobile] | true | Integer | 
data[password] | true | String | 

-----

#### GET /assistant/current_user(.:format)  

Display the current login user's details.

-----

#### GET /assistant/vip_card_orders(.:format)  

Display all vip card orders' informations of current login dealer.

-----

#### GET /assistant/vip_card_orders/:id(.:format)  

Display specified vip card order's details.

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  

-----

#### POST /assistant/vip_card_orders/search(.:format)  

Search vip card orders by mobile and plate_num.

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
query | true | String | 

-----

#### POST /assistant/vip_card_orders/:id/use(.:format)  

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

#### GET /assistant/operating_records(.:format)  

Display all operating records' informations of current login dealer.

-----

#### GET /assistant/operating_records/:id(.:format)  

Display specified operating record's details.

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  

-----

#### POST /assistant/operating_records(.:format)  

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

#### GET /assistant/sales_cases(.:format)  

Display all sales cases' informations of current login dealer.

-----

#### GET /assistant/sales_cases/:id(.:format)  

Display specified sales case's details.

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  

-----

#### POST /assistant/sales_cases(.:format)  

Create a new sales case.

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
data[user_mobile] | true | String | 客户手机号
data[description] | true | String | 客户问题描述
data[solution] | true | String | 推荐方案
data[adviser] | true | String | 服务顾问
data[state_id] | false | Integer | 状态ID：1.跟踪 2.解决 3.取消

-----

#### POST /assistant/sales_cases/search(.:format)  

Search sales cases by mobile and plate_num.

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
query | true | String | 

-----

#### POST /assistant/user_infos/search(.:format)  

Search user information by mobile and plate_num.

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
query | true | String | 

-----
