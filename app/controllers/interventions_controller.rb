class InterventionsController < ApplicationController
  before_action :find_issue
  before_action :set_intervention, only: [:show, :edit, :update, :destroy]

  # GET /interventions
  def index
    @interventions = @issue.interventions
  end

  # GET /interventions/1
  def show
  end

  # GET /interventions/new
  def new
    @intervention = @issue.interventions.first_or_initialize
    render_403 if @intervention.travaux_termines?
  end

  # GET /interventions/1/edit
  def edit
  end

  # POST /interventions
  def create
    @intervention            = @issue.interventions.first_or_initialize
    @intervention.attributes = intervention_params
    @intervention.project_id = @issue.project_id
    @intervention.user_id    = User.current.id
    if @intervention.save
      redirect_to @issue, notice: 'Intervention was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /interventions/1
  def update
    if @intervention.update(intervention_params)
      redirect_to @issue, notice: 'Intervention was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /interventions/1
  def destroy
    @intervention.destroy
    redirect_to @issue, notice: 'Intervention was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_intervention
    @intervention = @issue.interventions.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def intervention_params
    params.require(:intervention).permit(:issue_id, :user_id, :batiment, :site, :nom_demandeur, :date_reclamation, :date_intevention, :equipe, :travaux_id, :nature_intervention_id, :description_travaux, :founitures, :oberservation, :travaux_termines, :remarque, :signature)
  end

  def find_issue
    # Issue.visible.find(...) can not be used to redirect user to the login form
    # if the issue actually exists but requires authentication
    @issue   = Issue.find(params[:issue_id])
    @project = @issue.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
