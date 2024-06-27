class Admin::GemBlogCategoriesController < ApplicationController
  layout 'admin'
  before_action :set_admin_gem_blog_category, only: %i[ show edit update destroy ]

  # GET /admin/gem_blog_categories or /admin/gem_blog_categories.json
  def index
    @admin_gem_blog_categories = GemBlogCategory.all
  end

  # GET /admin/gem_blog_categories/1 or /admin/gem_blog_categories/1.json
  def show
  end

  # GET /admin/gem_blog_categories/new
  def new
    @admin_gem_blog_category = GemBlogCategory.new
  end

  # GET /admin/gem_blog_categories/1/edit
  def edit
  end

  # POST /admin/gem_blog_categories or /admin/gem_blog_categories.json
  def create
    @admin_gem_blog_category = GemBlogCategory.new(admin_gem_blog_category_params)

    respond_to do |format|
      if @admin_gem_blog_category.save
        format.html { redirect_to admin_gem_blog_category_url(@admin_gem_blog_category), notice: "Gem blog category was successfully created." }
        format.json { render :show, status: :created, location: @admin_gem_blog_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_gem_blog_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/gem_blog_categories/1 or /admin/gem_blog_categories/1.json
  def update
    respond_to do |format|
      if @admin_gem_blog_category.update(admin_gem_blog_category_params.except(:image))
        if admin_gem_blog_category_params[:image].present?
          @admin_gem_blog_category.image.attach(admin_gem_blog_category_params[:image])
        end
        format.html { redirect_to admin_gem_blog_category_url(@admin_gem_blog_category), notice: "Gem blog category was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_gem_blog_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_gem_blog_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/gem_blog_categories/1 or /admin/gem_blog_categories/1.json
  def destroy
    @admin_gem_blog_category.destroy!

    respond_to do |format|
      format.html { redirect_to admin_gem_blog_categories_url, notice: "Gem blog category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_gem_blog_category
      @admin_gem_blog_category = GemBlogCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_gem_blog_category_params
      params.require(:gem_blog_category).permit(:name, :description, :active, :image)
    end
end
