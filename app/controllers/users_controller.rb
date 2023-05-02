class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.order(:name)
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @user.build_address
  end

  # GET /users/1/edit
  def edit 
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: "User #{@user.name} was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params) && @user.addresses.first.update(user_params[:addresses_attributes]['0'])
        format.html { redirect_to users_url, notice: "User #{@user.name} was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    if @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to users_url, notice: "User cannot be destroyed." }
      end
    end
  end
  rescue_from 'StandardError' do |exception|
    redirect_to users_url, notice: exception.message
  end

  def show_orders
    @user = User.includes(orders: { line_items: :product }).find(session[:user_id])
    render layout: "myorders"
  end

  def show_line_items
    params[:page_number] ||= 0
    user = User.includes(line_items: :product).find(session[:user_id])
    @line_items = user.line_items.limit(5).offset(params[:page_number].to_i * 5)
    @page_number = params[:page_number].to_i
    render layout: "myorders"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, address_attributes: [:id, :state, :city, :country, :pincode])
    end
end
