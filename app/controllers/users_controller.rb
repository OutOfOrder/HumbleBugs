class UsersController < ApplicationController
  filter_resource_access :additional_member => {:sign_nda => :nda, :confirm => :update}

  # GET /users
  # GET /users.json
  def index
    @users = User.with_permissions_to.order('users.name ASC').includes(:developer, :roles)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  # GET /users/new.json
  def new
  end

  # GET /users/1/edit
  def edit
  end

  # GET /users/1/nda
  def nda
  end

  # POST /users/1/nda
  def sign_nda
    if params[:agree]
      @user.update_attribute(:nda_signed_date, Time.now)
      render json: {success: true, date: l(@user.nda_signed_date)}, status: :ok
    else
      render text: 'invalid request', status: 400
    end
  end

  # POST /users
  # POST /users.json
  def create
    if @user.save
      redirect_to login_url, notice: 'Signed Up!'
      @user.send_confirm_account
      UserMailer.new_account(@user).deliver
    else
      @user.errors.delete(:password_digest)
      render action: "new"
    end
  end


  def confirm
    @user.send_confirm_account
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    options = {}
    if @user.permitted_to? :update_roles
      roles = (params[:roles] || {}).keys.map(&:to_sym)
      cur_roles = @user.role_symbols
      added = roles - cur_roles
      removed = cur_roles - roles

      @user.roles.each do |r|
        r.mark_for_destruction if removed.include?(r.role.to_sym)
      end
      added.each do |r|
        @user.roles.build :role => r.to_s
      end

      options[:as] = :manager
    end

    if @user.update_attributes(params[:user], options)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    redirect_to users_url
  end
end
