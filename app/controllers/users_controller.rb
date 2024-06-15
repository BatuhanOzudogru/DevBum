class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @albums = fetch_albums(params[:id])

    unless @albums
      flash.now[:alert] = 'Kullanıcıya ait albümler bulunamadı.'
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def search
    if params[:query].present?
      @users = User.where('username LIKE ?', "%#{params[:query]}%")
      if @users.empty?
        flash.now[:alert] = 'Kullanıcı Bulunamadı!'
      end
    else
      @users = User.all
    end
    render 'index'
  end

  def destroy
    @user.destroy
  end

  def album_details
    album_response = HTTParty.get("https://jsonplaceholder.typicode.com/albums/#{params[:album_id]}")
    photo_response = HTTParty.get("https://jsonplaceholder.typicode.com/photos?albumId=#{params[:album_id]}")

    if album_response.code == 200 && photo_response.code == 200
      album = JSON.parse(album_response.body)
      photo_details = JSON.parse(photo_response.body)

      if photo_details.is_a?(Array) && photo_details.any?
        render json: {
          title: album['title'],
          id: album['id'],
          url: photo_details.first['url'],
          thumbnailUrl: photo_details.first['thumbnailUrl']
        }
      else
        render json: { error: 'Bu albüm için fotoğraf bulunamadı' }, status: :not_found
      end
    else
      render json: { error: 'Albüm veya fotoğraflar alınamadı' }, status: :bad_request
    end
  end
  
  def fetch_albums(user_id)
    response = HTTParty.get("https://jsonplaceholder.typicode.com/albums?userId=#{user_id}")
    JSON.parse(response.body)
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :phone, :website)
  end
end
