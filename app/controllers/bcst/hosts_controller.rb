class Bcst::HostsController < Bcst::ApplicationController
  set_resource_class Bcst::Host

  def data_params
    params.require(:bcst_host).permit(:name, :description, :avatar, programme_ids: [])
  end
  
  def i18n_message message_type, model
    options = { model: I18n.t(model, scope: 'activerecord.models') }
    options[:title] = @bcst.name if @bcst.respond_to? :name
    I18n.t(message_type, options)
  end

end
