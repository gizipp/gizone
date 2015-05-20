class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy, :update_whitelist]
  before_action :authenticate_user!

  # GET /links
  # GET /links.json
  def index
    @links = Link.where(blog_id: Blog.find(params[:blog_id]))
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to blog_link_path(@link.blog_id, @link.id), notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_whitelist
    respond_to do |format|
      if @link.update(whitelist: params[:whitelist])
        format.html { render :edit, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit, notice: 'Link was unsuccessfully updated.' }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  protected
    def fetch_links
      @page = MetaInspector.new('http://backpackstory.me/2015/02/01/kaleidoskop-2014-tahun-penuh-pencapaian/',
              :warn_level => :store,
              :connection_timeout => 5, :read_timeout => 5)
      @page.links.internal.each do |link|
        uri = URI(link)
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:path, :whitelist, :blacklist, :unreachable)
    end

    def user_agent
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36"
    end
end
