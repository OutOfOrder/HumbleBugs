class UsersController < ApplicationController
  filter_resource_access :additional_member => {:sign_nda => :nda}

  # GET /users
  # GET /users.json
  def index
    @users = User.with_permissions_to.order('users.name ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
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
    respond_to do |format|
      if @user.save
        format.html { redirect_to login_url, notice: 'Signed Up!' }
        format.json { render json: @user, status: :created, location: @user }
        @user.send_confirm_account
      else
        @user.errors.delete(:password_digest)
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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

    respond_to do |format|
      if @user.update_attributes(params[:user], options)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
