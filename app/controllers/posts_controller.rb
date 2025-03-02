#posts_controller.rb
class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  #@view_comments = params[:view_comments].present? ? params[:view_comments].to_i : 0

  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.all
    #@comments = @post.comments.includes(:user)
    @view_comments = params[:view_comments].present? ? params[:view_comments].to_i : 0
    #@comment = @post.comment
    @commentable = @post 
    puts "Profile ID in the URL: #{params[:id]}"
  end

  # GET /posts/new
  def new
    @post = Post.new
    puts @current_user
    puts "Current User ID: #{current_user.email}"
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    #@post = Post.new(post_params)
    @post = current_user.posts.build(post_params)
    puts "Current User ID: #{current_user.email}"
    puts "Post User ID: #{@post.user_id}"

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id)
    end
end
