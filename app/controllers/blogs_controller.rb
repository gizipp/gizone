class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :do_crawling, :do_indexing, :drop_indexing]
  before_action :authenticate_user!
  after_action :reindex, only: [:do_indexing, :drop_indexing]

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def do_crawling
    @blog.fetch_links
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Blog was successfully crawled.' }
      format.json { head :no_content }
    end
  end

  def do_indexing
    @blog.links.white.each do |link|
      link.fetch_article
    end
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Blog was successfully (re)indexed.' }
      format.json { head :no_content }
    end
  end

  def drop_indexing
    @blog.articles.delete_all
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Blog was successfully reseted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:domain, :title_selector, :content_selector)
    end
end
