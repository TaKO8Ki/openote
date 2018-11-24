class ArticlePicturesController < InheritedResources::Base

  def new
    @article_picture = ArticlePicture.new
  end

  def create
    @article_picture = ArticlePicture.new(article_picture_params)
    @article_picture.user_id = current_user.id
    if @article_picture.save
      respond_to do |format|
        format.json { render json: @article_picture}
      end
    end
  end


  private

    def article_picture_params
      params.require(:article_picture).permit(:user_id, :picture)
    end
end
