class Tips::TestDriving < ActiveRecord::Base
  include Tips::Servicable
  set_order_class Tips::TestDrivingOrder

  extend Share::ImageAttachments
  define_image2_method
  
  include Share::Statisticable
  
  enumerate :brand, with: Category::Brand

  validates_presence_of :dealer
  validates_presence_of :title, :price, :brand_id, :series

  serialize :params, Hash

  def params= params
    super params.select { |k, v| v.present? }
  end

  def grouped_params
    params.group_by { |k, v| ParamsFindMap[k] }
  end

  Params = {
    "基本参数" => %w(厂商 级别 发动机 变速箱 车身结构 最高时速（km/h） 整车质保),
    "车体" => %w(长×宽×高（mm） 轴距（mm） 前轮距（mm） 后轮距（mm） 最小离地空隙（mm） 整备质量（kg） 油箱容积（L） 行李箱容积（L）),
    "发动机" => %w(发动机型号 排量（L） 进气形式 气缸排列形式 气缸数（个） 每缸气门数（个） 气门结构 压缩比 缸径（mm） 行程（mm） 最大马力（ps） 最大功率（kw） 最大功率转速（rpm） 最大扭矩（N·m） 最大扭转速度（rpm） 燃料类型 燃油标号 供油方式 缸盖材料 缸体材料 环保标准),
    "变速箱" => %w(变速箱),
    "底盘转向" => %w(驱动方式 前悬架类型 后悬架类型 助力类型 车体结构),
    "车轮制动" => %w(前制动器类型 后制动器类型 驻车制动类型 前轮胎规格 后轮胎规格 备胎规格 轮毂材料),
    "安全配置" => %w(驾驶座安全气囊 副驾驶座安全气囊 前排侧气囊 后排侧气囊 胎压监测装置 安全带未系提示 儿童安全座椅接口 发动机电子防盗 车内中控锁 遥控钥匙 无钥匙启动系统 无钥匙进入系统),
    "操控配置" => %w(ABS防抱死 制动力分配（EBD/CBC） 刹车辅助（EBA/BAS/BA） 牵引力控制（ESC/ESP/DSC） 自动驻车/上坡辅助 陡坡缓降 可变悬架 空气悬架 可变转向比 前桥限滑差速器/差速锁 中央差速锁止功能 后桥限滑差速器/差速锁),
    "外部配置" => %w(电动天窗 全景天窗 运动外观套件 铝合金轮毂 电动吸合门),
    "内部配置" => %w(真皮方向盘 方向盘调节 方向盘电动调节 多功能方向盘 方向盘换挡 方向盘加热 定速巡航 前/后驻车雷达 倒车视频影像 行车电脑显示 HUD抬头数字显示),
    "座椅配置" => %w(真皮/仿皮座椅 运动风格座椅 座椅高低调节 腰部支撑调节 肩部支撑调节 驾驶座电动调节 副驾驶座电动调节 后排座椅电动调节 电动座椅记忆 座椅加热 座椅按摩 座椅通风 前后座中央扶手 电动后备箱),
    "多媒体" => %w(GPS导航系统 定位互动系统 中控彩色触屏 人机交互系统 内置硬盘 蓝牙/车载电话 车载电视 后排液晶屏 外接音源接口 CD支持MP3/WMA 多媒体系统 扬声器数量),
    "灯光配置" => %w(疝气大灯 LED大灯 日间行车大灯 自动头灯 转向大灯（辅助灯） 前雾灯 大灯高度可调 大灯清洗装置 车内氛围灯),
    "玻璃/后视镜" => %w(前/后电动车窗 车窗防夹手功能 防紫外线/隔热玻璃 后视镜电动调节 后视镜加热 内外后视镜自动防眩光 后视镜电动折叠 后视镜记忆 后风挡遮阳帘 后排侧遮阳帘 后排侧隐私玻璃 遮阳板化妆镜 后雨刷 感应雨刷),
    "冰箱/空调" => %w(空调控制方式 后排独立空调 后座出风口 温度分区控制 车内空气调节 车载冰箱),
    "顶级配置" => %w(自动泊车 发动机启停技术 并线辅助 车道偏离预警 主动安全系统 整体主动转向系统 夜视系统 中控液晶屏分屏显示 自动巡航 全景摄像头),
  }

  ParamsFindMap = {}
  Params.each do |group, titles|
    titles.each do |title|
      ParamsFindMap[title] = group
    end
  end

end


