class RelationshipsController < ApplicationController
	before_action :authenticate_user!

	def create
		follow = current_user.active_relationships.build(followed_id: params[:user_id])
			if follow.save
				redirect_to users_path, notice: "フォローしました"
			else
				redirect_to users_path, alert: "フォローできませんでした"
			end
	end

	def destroy
		follow = current_user.active_relationships.find_by!(followed_id: params[:user_id])
		follow.destroy
		redirect_to users_path, notice: "フォロー解除しました"
	end
end
