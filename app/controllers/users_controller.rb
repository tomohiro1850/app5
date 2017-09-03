class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :check_correct_user, only: [ :edit, :update]
	before_action :set_user, only: [ :show, :favorites]
	

	def show
	  	@posts = @user.posts.order(updated_at: :desc)
	  	@post = Post.new
	end

  	def index
  		@users = User.all
  		@post = Post.new
  	end

	def edit
	end

	def favorites
	end

	def follows
  		@user = User.find(params[:id])
  		@follows = @user.followings
  	end

  	def followers
  		@user = User.find(params[:id])
  		@followers = @user.followers
  	end


	def update
		if @user.update(user_params)
			redirect_to user_path(@user),notice: 'Updated your information!'
		else
			render :edit,notice: 'Failed to update, sorry.'
		end
	end

	private
		def set_user
			@user = User.find(params[:id])
		end

		def user_params
			params.require(:user).permit(:name, :intro, :image)
		end

		def check_correct_user
			set_user
			if !correct_user?(@user)
				render :show
			end
		end
end
