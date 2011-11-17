class ResultsController < BaseController
  before_filter :load_hierarchy, :only => [:index, :edit]

  load_resource :exercise
  load_resource :result

  def create
    @result = @exercise.start_for(current_user)

    respond_to do |format|
      format.html do
        redirect_to exercise_question_path(@exercise, @exercise.questions.first)
      end
    end
  end

  def update
    @exercise.finalize_for(current_user)
    @subject = @exercise.lecture.subject
    @space = @subject.space

    respond_to do |format|
      format.html do
        redirect_to \
          space_subject_lecture_path(@space, @subject, @exercise.lecture)
      end
    end
  end

  def edit
    @first_question = @exercise.questions.
      first(:conditions => { :position => 1})
    @last_question = @first_question.last_item
    @result = @exercise.result_for(current_user, false)

    respond_to do |format|
      format.html { render 'questions/show' }
    end
  end

  def index
    @results = @exercise.results.finalized.includes(:user, :choices,
                                                    :exercise => :questions)

    respond_to do |format|
      format.html { render 'results/admin/index' }
    end
  end

  protected

  def load_hierarchy
    @exercise = Exercise.find(params[:exercise_id])
    @lecture = @exercise.lecture
    @subject = @lecture.subject
    @space = @subject.space
    @course = @space.course
    @environment = @course.environment
  end
end
