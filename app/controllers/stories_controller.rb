class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  # GET /stories
  def index
    @stories = Story.bv_descending
  end

  # GET /stories/1
  def show
    @comment = Comment.new(story_id: @story.id)
  end

  # GET /stories/new
  def new
    @story = Story.new
    @projects = Project.all
  end

  # GET /stories/1/edit
  def edit
    @projects = Project.all
  end

  # POST /stories
  def create
    @story = Story.new(story_params)
    @projects = Project.all

    if @story.save
      redirect_to @story, notice: 'Story was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /stories/1
  def update
    if @story.update(story_params)
      redirect_to @story, notice: 'Story was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /stories/1
  def destroy
    @story.destroy
    redirect_to stories_url, notice: 'Story was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id], include: :comments)
    end

    # Only allow a trusted parameter "white list" through.
    def story_params
      params.require(:story).permit(:goal, :stakeholder, :behavior, :business_value, :complexity_value, :tag, :assignee, :project_id)
    end
end
