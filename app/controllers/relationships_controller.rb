class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
=begin
    _follow.html.erb内で<div><%= f.hidden_field :followed_id %></div>を行っており、
    上記をパラメータとして登録しているため、params[:relationship][:followed_id]と書く必要がある。
    htmlだと、<input id="relationship_followed_id" name="relationship[followed_id]" type="hidden" value="6">
    p "=============================================================================================="
    p params[:relationship][:followed_id] #自分のIDが入る
    p "=============================================================================================="
=end
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    redirect_to @user
  end

  def destroy
=begin    
    p "=============================================================================================="
    p params[:id] #relationshipのIDが入る
    p "=============================================================================================="
    @user = Relationship.find(params[:id]).followedを実行することで、
    SELECT "relationships".* FROM "relationships" WHERE "relationships"."id" = idが実行され、
    その後Userテーブルに対してSELECT "users".* FROM "users" WHERE "users"."id" = followed_idが実行される
    これは、Relationshipモデルでbelongs_toで指定して関連付けを行ったため。
=end
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    redirect_to @user
  end
end