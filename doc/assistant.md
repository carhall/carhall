Assistant Api
=====

### POST /login(.:format)  

Login by mobile and password.

Parameters:

Name | Required | Type
---- | -------- | ---- 
mobile | true | Integer
password | true | String

-----

### GET /current_user(.:format)  

Show detail

-----

### GET /vip_card_orders(.:format)  

List infos

-----

### GET /vip_card_orders/:id(.:format)  

Show detail

Parameters:

Name | Required | Type
---- | -------- | ---- 
id | true |  

-----

### POST /vip_card_orders/search(.:format)  

Search by mobile and plate_num.

Parameters:

Name | Required | Type
---- | -------- | ---- 
query | true | String

-----

### POST /vip_card_orders/:id/use(.:format)  

Set used_count

Parameters:

Name | Required | Type
---- | -------- | ---- 
id | true |  
data | true | Hash

-----
