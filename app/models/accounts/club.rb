class Accounts::Club <  Accounts::PublicAccount


	MENU= {"button"=>
      [{"name"=>"淘服务",
        "sub_button"=>
         [
         	{"type"=>"click",
           "name"=>"免费券",
           "key"=>"free_ticket"},
           {"type"=>"click",
             "name"=>"团购",
             "key"=>"tuangou"},
           ]},
         {"name"=>"养车攻略",
          "sub_button"=>
         [{"type"=>"click",
           "name"=>"保养",
           "key"=>"baoyang",
           },
           {"type"=>"click",
           "name"=>"洗车",
           "key"=>"xiche"
           },
          ]},
        {"name"=>"我的",
        "sub_button"=>
         [{"type"=>"view",
           "name"=>"联系客服",
           "url"=>"http://115.28.13.212/dashboard/about_us",
           },{"type"=>"click",
           "name"=>"预约订单",
           "key"=>"yuding",
           },{"type"=>"view",
           "name"=>"违章查询",
           "url"=>"http://www.lolhelper.cn/all/",
           },
           {"type"=>"click",
           "name"=>"会买车",
           "key"=>"buycar",
           }
           ]}
           ]}
end