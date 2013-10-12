module Share::Displayable
  extend ActiveSupport::Concern

  included do
    scope :displayed, -> { where(display: true) }
    scope :positioned, -> { order("position DESC") }

  end

  def displayed?
    display
  end

  def expose
    self.display = true
  end

  def hide
    self.display = false
  end

  def sticked?
    position == 1
  end

  def stick
    self.position = 1
  end

  def unstick
    self.position = 0
  end

  def human_state
    return "隐藏" unless display
    return "置顶" unless position == 0
    "显示"
  end

  extend Share::Exclamation
  define_exclamation_and_method :expose
  define_exclamation_and_method :hide
  define_exclamation_and_method :stick
  define_exclamation_and_method :unstick

end
