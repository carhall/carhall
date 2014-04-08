Assistant Api
=====

#### GET /assistant/version(.:format)  

获取更新信息

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
version | true |  | 当前版本号

-----

#### GET /assistant/users/:user_id/sales_cases(.:format)  

显示当前登录商户的所有销售跟踪记录

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
user_id | true |  |  

-----

#### GET /assistant/users/:user_id/sales_cases/:id(.:format)  

显示指定销售跟踪记录详情

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
user_id | true |  |  
id | true |  |  

-----

#### POST /assistant/users/:user_id/sales_cases(.:format)  

新建一条销售跟踪记录

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
user_id | true |  |  
data[user_id] | true | Integer | 客户ID
data[description] | true | String | 客户问题描述
data[solution] | true | String | 推荐方案
data[adviser] | true | String | 服务顾问
data[state_id] | false | Integer | 状态ID：1.跟踪 2.解决 3.取消

-----

#### PUT /assistant/users/:user_id/sales_cases/:id(.:format)  

编辑一条销售跟踪记录

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
user_id | true |  |  
id | true |  |  
data[user_id] | true | Integer | 客户ID
data[description] | true | String | 客户问题描述
data[solution] | true | String | 推荐方案
data[adviser] | true | String | 服务顾问
data[state_id] | false | Integer | 状态ID：1.跟踪 2.解决 3.取消

-----

#### POST /assistant/users/:user_id/sales_cases/search(.:format)  

通过手机号或车牌号搜索销售跟踪记录

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
user_id | true |  |  
query | true | String | 手机号或车牌号

-----

#### GET /assistant/users/:user_id/consumption_records(.:format)  

显示当前登录商户的该用户的所有消费记录

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
user_id | true |  |  

-----
