class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by(name: params[:name])

    if @hashtag.present?
      @questions = @hashtag.questions.order(created_at: :desc)
    else
      redirect_to root_path, alert: 'Такого хэштега не существует!'
    end
  end
end
