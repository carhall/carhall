Assistant Api
=====

#### POST /login(.:format)  

Login by mobile and password.

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
mobile | true | Integer | 
password | true | String | 

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
