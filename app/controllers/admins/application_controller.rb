class Admins::ApplicationController < ApplicationController

  def self.set_resource_class klass, options = {}
    before_filter :set_admin
    before_filter :set_user, only: [:show, :edit, :update, :destroy]

    define_method :index do
      @users = klass.all.page params[:page]
    end

    define_method :show do
    end

    define_method :new do
      @user = klass.new
    end

    define_method :create do
      @user = klass.new params[klass.name.underscore]

      if @user.save
        index_path = { action: :index }
        redirect_to index_path, flash: { success: i18n_message(:create_success, klass.name.underscore) }
      else
        render :new
      end
    end

    define_method :edit do
    end

    define_method :update do
      @user = klass.find(params[:id])

      if @user.update_attributes(params[klass.name.underscore])
        index_path = { action: :index }
        redirect_to index_path, flash: { success: i18n_message(:update_success, klass.name.underscore) }
      else
        render :edit
      end
    end

    define_method :destroy do
      authorize! :destroy, @user
      index_path = { action: :index }
      redirect_to index_path, flash: { success: i18n_message(:destroy_success, klass.name.underscore) }
    end

    define_method :set_user do
      @user = klass.find(params[:id])
    end
  end

  def i18n_message message_type, model
    options = { model: I18n.t(model, scope: 'activerecord.models') }
    options[:title] = @user.username if @user.respond_to? :username
    I18n.t(message_type, options)
  end

end