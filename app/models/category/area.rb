class Category::Area < ActiveEnum::Base
  AreaMap = {
    "北京市" => %w(北京), 
    "上海市" => %w(上海), 
    "天津市" => %w(天津), 
    "重庆市" => %w(重庆), 
    "香港特别行政区" => %w(香港), 
    "澳门特别行政区" => %w(澳门),
    "河北省" => %w(石家庄 沧州 承德 秦皇岛 唐山 保定 廊坊 邢台 衡水 张家口 邯郸 任丘 河间 泊头 武安 沙河 南宫 深州 冀州 黄骅 高碑店 安国 涿州 定州 三河 霸州 迁安 遵化 鹿泉 新乐 晋州 藁城 辛集), 
    "山西省" => %w(太原 长治 大同 阳泉 朔州 临汾 晋城 忻州 运城 晋中 吕梁 古交 潞城 高平 原平 孝义 汾阳 介休 侯马 霍州 永济 河津), 
    "辽宁省" => %w(沈阳 大连 本溪 阜新 葫芦岛 盘锦 铁岭 丹东 锦州 营口 鞍山 辽阳 抚顺 朝阳 瓦房店 兴城 新民 普兰店 庄河 北票 凌源 调兵山 开原 灯塔 海城 凤城 东港 大石桥 盖州 凌海 北镇), 
    "吉林省" => %w(长春 白城 白山 吉林 辽源 四平 通化 松原 延边 珲春 龙井 舒兰 临江 公主岭 梅河口 德惠 九台 榆树 磐石 蛟河 桦甸 洮南 大安 双辽 集安 图们 敦化 和龙), 
    "黑龙江省" => %w(哈尔滨 大庆 大兴安岭 鹤岗 黑河 鸡西 佳木斯 牡丹江 七台河 双鸭山 齐齐哈尔 伊春 绥化 虎林 五常 密山 宁安 漠河 海伦 肇东 安达 海林 绥芬河 富锦 同江 铁力 五大连池 北安 讷河 阿城 尚志 双城), 
    "江苏省" => %w(南京 苏州 扬州 无锡 南通 常州 连云港 徐州 镇江 淮安 宿迁 泰州 太仓 盐城 高邮 新沂 金坛 溧阳 淮阴 江宁 睢宁 清江 昆山 常熟 江阴 宜兴 邳州 张家港 吴江 如皋 海门 启东 大丰 东台 仪征 扬中 句容 丹阳 兴化 姜堰 泰兴 靖江), 
    "浙江省" => %w(杭州 宁波 温州 丽水 奉化 宁海 临海 三门 绍兴 舟山 义乌 北仑 慈溪 象山 余姚 天台 温岭 仙居 台州 嘉兴 湖州 衢州 金华 余杭 德清 海宁 临安 富阳 建德 平湖 桐乡 诸暨 上虞 嵊州 江山 兰溪 永康 东阳 瑞安 乐清 龙泉), 
    "安徽省" => %w(合肥 黄山 芜湖 铜陵 安庆 滁州 宣城 阜阳 淮北 蚌埠 池州 青阳 九华山景区 黄山景区 巢湖 亳州 马鞍山 宿州 六安 淮南 绩溪 界首 明光 天长 桐城 宁国), 
    "福建省" => %w(福州 厦门 泉州 漳州 龙岩 三明 南平 永安 宁德 莆田 闽侯 福鼎 罗源 仙游 福清 长乐 云霄 长泰 东山岛 邵武 石狮 晋江 建阳 福安 漳平 龙海 南安 建瓯 武夷山), 
    "江西省" => %w(南昌 九江 赣州 景德镇 萍乡 新余 吉安 宜春 抚州 上饶 鹰潭 陵川 瑞金 井冈山 瑞昌 乐平 南康 德兴 丰城 樟树 高安 贵溪), 
    "山东省" => %w(济南 青岛 烟台 威海 潍坊 德州 滨州 东营 聊城 菏泽 济宁 临沂 淄博 泰安 枣庄 日照 莱芜 海阳 平度 莱阳 青州 肥城 章丘 即墨 利津 武城 桓台 沂源 曲阜 龙口 胶州 胶南 莱西 临清 乐陵 禹城 安丘 昌邑 高密 诸城 寿光 栖霞 莱州 蓬莱 招远 文登 荣成 乳山 滕州 兖州 邹城 新泰), 
    "河南省" => %w(郑州 安阳 济源 鹤壁 焦作 开封 濮阳 三门峡 驻马店 商丘 新乡 信阳 许昌 周口 南阳 洛阳 平顶山 漯河 中牟 洛宁 荥阳 登封 项城 灵宝 义马 舞钢 长葛 禹州 林州 辉县 卫辉 沁阳 孟州 偃师 新密 登封 新郑 汝州 永城 邓州 巩义), 
    "湖北省" => %w(武汉 十堰 宜昌 鄂州 黄石 襄樊 荆州 荆门 孝感 黄冈 咸宁 随州 恩施 仙桃 天门 潜江 神农架 沙市 老河口 利川 当阳 枝江 宜都 松滋 洪湖 石首 赤壁 大冶 麻城 武穴 广水 安陆 应城 汉川 钟祥 宜城 枣阳 丹江口), 
    "湖南省" => %w(长沙 张家界 株洲 韶山 衡阳 郴州 冷水江 娄底 耒阳 永州 湘乡 湘潭 常德 益阳 怀化 邵阳 岳阳 吉首 大庸 韶山 常宁 浏阳 津市 沅江 汨罗 临湘 醴陵 资兴 武冈 洪江), 
    "广东省" => %w(广州 深圳 珠海 东莞 佛山 潮州 汕头 湛江 中山 惠州 河源 揭阳 梅州 肇庆 茂名 云浮 阳江 江门 韶关 乐昌 化州 从化 鹤山 汕尾 清远 顺德 雷州 廉江 吴川 高州 信宜 阳春 罗定 四会 高要 开平 台山 恩平 陆丰 普宁 兴宁 南雄 连州 英德 增城), 
    "广西壮族自治区" => %w(南宁 柳州 北海 百色 梧州 贺州 玉林 河池 桂林 钦州 防城港 来宾 崇左 贵港 北流 宜州 桂平 岑溪 东兴 凭祥 合山), 
    "海南省" => %w(海口 三亚 琼海 儋州 文昌 万宁 东方 五指山), 
    "四川省" => %w(成都 内江 峨眉山 绵阳 宜宾 泸州 攀枝花 自贡 资阳 崇州 西昌 都江堰 遂宁 乐山 达州 江油 大邑 金堂 德阳 南充 广安 广元 巴中 雅安 眉山 阿坝 甘孜 三台 丹棱 梁平 万县 广汉 汶川县 什邡 彭州 绵竹 邛崃 阆中 华蓥 万源 简阳), 
    "贵州省" => %w(贵阳 安顺 铜仁 六盘水 遵义 毕节 兴义 凯里 都匀 福泉 仁怀 赤水 清镇), 
    "云南省" => %w(昆明 西双版纳 大理 德宏 思茅 玉溪 曲靖 保山 昭通 临沧 丽江 文山 个旧 楚雄 迪庆 宜良 沅江 安宁 宣威 瑞丽 开远 景洪), 
    "西藏自治区" => %w(拉萨 那曲 昌都 山南 日喀则 阿里 林芝), 
    "陕西省" => %w(西安 宝鸡 延安 兴平 咸阳 铜川 渭南 汉中 榆林 安康 商洛 周至 韩城 华阴), 
    "甘肃省" => %w(兰州 嘉峪关 酒泉 临夏 白银 天水 武威 张掖 平凉 庆阳 定西 陇南 甘南 敦煌 金昌 玉门), 
    "青海省" => %w(西宁 海东 海北 黄南 海南 果洛 海西 玉树 格尔木), 
    "内蒙古自治区" => %w(呼和浩特 呼伦贝尔 包头 赤峰 鄂尔多斯 巴彦淖尔盟 阿拉善盟 兴安盟 通辽 乌海 乌兰察布盟 锡林郭勒盟 满洲里 扎兰屯 牙克石 根河 额尔古纳 阿尔山 霍林郭勒 二连浩特 丰镇), 
    "宁夏回族自治区" => %w(银川 石嘴山 吴忠 固原 中卫 灵武 青铜峡), 
    "新疆维吾尔自治区" => %w(乌鲁木齐 克拉玛依 哈密 喀什 吐鲁番 石河子 图木舒克 和田 昌吉 阿图什 库尔勒 博乐 伊宁 阿拉尔 阿克苏 五家渠 北屯 阜康 米泉 奎屯 塔城 乌苏 阿勒泰), 
    "台湾省" => %w(台北 台中 台南 高雄 基隆 新竹 嘉义 宜兰 桃园 彰化 苗栗 云林 屏东 彭湖 花莲), 
  }
  Areas = AreaMap.values.flatten.uniq

  value Areas

  # class << self
  #   def get(index)
  #     return nil if index.nil?
  #     if index.is_a?(Fixnum)
  #       row = store.get_by_id(index)
  #       row[1] if row
  #     else
  #       Areas.find_index do |area|
  #         area.start_with? index.to_s
  #       end + 1
  #     end
  #   end
  #   alias_method :[], :get
  # end

end