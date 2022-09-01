class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by(name: params[:name])
    @questions = @hashtag.questions.order(created_at: :desc)
  end
end
