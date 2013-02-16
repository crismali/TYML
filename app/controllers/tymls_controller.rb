class TymlsController < ApplicationController
  # GET /tymls
  # GET /tymls.json

  before_filter :authenticate_user!, :only => [:index, :show, :edit, :update, :destroy, :new]

  def index

      if user_signed_in?
        redirect_to '/dashboard'
      else
      @tymls = Tyml.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @tymls }
      end
    end
  end

  # GET /tymls/1
  # GET /tymls/1.json
  def show
    @tyml = Tyml.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tyml }
    end
  end

  # GET /tymls/new
  # GET /tymls/new.json
  def new
    @tyml = Tyml.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tyml }
    end
  end

  # GET /tymls/1/edit
  def edit
    @tyml = Tyml.find(params[:id])
  end

  # POST /tymls
  # POST /tymls.json
  def create
    @tyml = Tyml.new#(params[:tyml]) params[:tyml][:receiver_id] IS NOT a receiver_id, it's
    # an email address that is searched for in the db via find by email method below. FIX THIS LATER
    #temporary for first builders' weekend
    @tyml.url = params[:tyml][:url]
    @tyml.note = params[:tyml][:note]
    @tyml.sender_id = params[:tyml][:sender_id]
    @tyml.receiver_id = User.find_by_email(params[:tyml][:receiver_id]).id unless User.find_by_email(params[:tyml][:receiver_id]).nil?



    respond_to do |format|
      if @tyml.save
        TymlMailer.notification(@tyml).deliver
        format.html { redirect_to @tyml, notice: 'Tyml was successfully created.' }
        format.json { render json: @tyml, status: :created, location: @tyml }
      else
        format.html { redirect_to dashboard_url }
        format.json { render json: @tyml.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tymls/1
  # PUT /tymls/1.json
  def update
    @tyml = Tyml.find(params[:id])

    @tyml.viewed = params[:viewed] #should be made more secure/tamper proof
    respond_to do |format|
      if @tyml.save
        format.html { redirect_to params[:url] }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tyml.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tymls/1
  # DELETE /tymls/1.json
  def destroy
    @tyml = Tyml.find(params[:id])
    @tyml.destroy

    respond_to do |format|
      format.html { redirect_to tymls_url }
      format.json { head :no_content }
    end
  end
end
