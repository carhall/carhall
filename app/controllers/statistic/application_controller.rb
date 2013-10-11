class Statistic::ApplicationController < ApplicationController
  before_filter :set_dealer
  before_filter :set_provider

end