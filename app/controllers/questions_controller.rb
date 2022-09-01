class QuestionsController < ApplicationController
  before_action :ensure_current_user, only: %i[update destroy edit]
  before_action :set_question_for_current_user, only: %i[update destroy edit]  
  
  def create
    question_params = params.require(:question).permit(:body, :user_id)
    
    @question = Question.new(question_params)
    @question.author = current_user

    if @question.save
      hashtag_names = find_hashtags(@question.body)

      hashtag_names.each do |hashtag_name|
        hashtag = Hashtag.find_or_create_by(name: hashtag_name)

        QuestionHashtag.create(question_id: @question.id, hashtag_id: hashtag.id)    
      end
  
      redirect_to user_path(@question.user), notice: 'Новый вопрос создан'
    else
      flash.now[:alert] = 'Не получилось создать вопрос'

      render :new
    end
  end

  def update
    question_params = params.require(:question).permit(:body, :answer)

    if @question.update(question_params)
      hashtag_names = find_hashtags("#{@question.body} #{@question.answer}")

      added_hashtags = hashtag_names - @question.hashtags.map(&:name)

      added_hashtags.each do |added_hashtag|
        hashtag = Hashtag.find_or_create_by(name: added_hashtag)

        QuestionHashtag.create(question_id: @question.id, hashtag_id: hashtag.id)    
      end

      removed_hashtags = @question.hashtags.map(&:name) - hashtag_names

      removed_hashtags.each do |removed_hashtag|
        hashtag = Hashtag.find_by(name: removed_hashtag)

        @question.question_hashtags.find_by(hashtag_id: hashtag.id).destroy
      end

      redirect_to user_path(@question.user), notice: 'Сохранили вопрос!'
    else
      flash.now[:alert] = 'Не получилось редактировать вопрос'

      render :edit
    end
  end

  def destroy
    @user = @question.user
    @question.destroy

    redirect_to user_path(@user), notice: 'Вопрос удалён!'
  end

  def show
    @question = Question.find(params[:id])
  end

  def index
    @questions = Question.order(created_at: :desc).first(10)
    @users = User.order(created_at: :desc).first(10)
  end

  def new
    @user = User.find(params[:user_id])
    @question = Question.new(user: @user)
  end

  def edit
  end

  private

  def ensure_current_user
    redirect_with_alert unless current_user.present?
  end

  def set_question_for_current_user
    @question = current_user.questions.find(params[:id])
  end

  def find_hashtags(text)
    text.scan(Hashtag::HASHTAG_REGEXP)
        .map { |hashtag| hashtag.delete('#').downcase }
        .uniq
  end
end
