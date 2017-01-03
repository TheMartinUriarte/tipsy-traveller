class CitiesController < ApplicationController

  def index
    cities_id = params[:cities_id]
    @cities = Cities.find_by(id: cities_id)
  end

  def new
    @post = Post.new
    cities_id = params[:cities_id]
    @cities = Cities.find_by(id: cities_id)
  end

  def create
    cities = Cities.find(params[:cities_id])
    new_post = Post.new(post_params)
    if new_post.save
      cities.post << new_post
      redirect_to cities_post_path(owner, new_post)
    else
      flash[:error] = new_post.errors.full_messages.join(", ")
      redirect_to new_cities_post_path(cities)
    end
  end

  def show
    post_id = params[:id]
    @post = Post.find_by(id: post_id)
    cities_id = params[:cities_id]
    @cities = Cities.find_by(id: cities_id)
  end

  def update
    cities_id = params[:cities_id]
    cities = Cities.find_by(id: cities_id)
    post_id = params[:id]
    post = Post.find_by(id: post_id)

    if post.update(post_params)
      flash[:notice] = "Updated successfully."
      redirect_to edit_cities_post_path(cities, post)
    else
      flash[:error] = post.errors.full_messages.join(", ")
      redirect_to edit_cities_post_path(cities, post)
    end
  end

  def destroy
    post_id = params[:id]
    post = Post.find_by(id: post_id)
    post.delete

    cities_id = params[:cities_id]
    cities = Cities.find_by(id: cities_id)
    redirect_to cities_post_path(cities)
  end

  private
  def post_params
    params.require(:pet).permit(:name, :breed, :date_of_birth)
  end

end
