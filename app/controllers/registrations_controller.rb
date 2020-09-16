class RegistrationsController < Devise::RegistrationsController
  def create
    @opts = params[:user][:user_option_ids] # REMOVE HELP OPTIONS
    params[:user].delete :user_option_ids
    super # DEVISE FINISH REGSITRATION
    @opts.each do |opt| # CREATE HELP OPTIONS
      UserOption.create(user: User.find_by(email: params[:user][:email]), help_option_id: opt.to_i, active: true) unless opt.empty?
    end
  end
end
