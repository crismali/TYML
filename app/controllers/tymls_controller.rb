=class TymlsController < ApplicationController
  # GET /tymls
  # GET /tymls.json

  before_filter :authenticate_user!, :only => [:index, :show, :edit, :update, :destroy, :new]

  def index
    @tymls = Tyml.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tymls }
    end
  end

  # GET /tymls/1
  # GET /tymls/1.json
  def show
    @tyml = Tyml.find(params[:id])
    @current_user = current_user
    @comment = Comment.new

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
    @tyml = Tyml.new(params[:tyml])
    comma = @tyml.receiver_email.include?(',')
    space = @tyml.receiver_email.strip.include?(' ')
    saved = false

    if comma
      emails = @tyml.receiver_email.split(',')
      emails.map! {|x| x.strip}

      emails.each do |email|
        @new_tyml = Tyml.new(params[:tyml])
        @new_tyml.receiver_email = email
        if @new_tyml.save
          TymlMailer.notification(@new_tyml).deliver
          @contact = Contact.new
          @contact.contact_email = @new_tyml.receiver_email
          @contact.user_id = @new_tyml.sender_id
          @contact.save
          saved = 'multi'
        end
      end
    elsif space
      emails = @tyml.receiver_email.split

      emails.each do |email|
        @new_tyml = Tyml.new(params[:tyml])
        @new_tyml.receiver_email = email
        if @new_tyml.save
          TymlMailer.notification(@new_tyml).deliver
          @contact = Contact.new
          @contact.contact_email = @new_tyml.receiver_email
          @contact.user_id = @new_tyml.sender_id
          @contact.save
          saved = 'multi'
        end
      end
    else
      @tyml.receiver_email.strip!

      if @tyml.save
        TymlMailer.notification(@tyml).deliver
        @contact = Contact.new
        @contact.contact_email = @tyml.receiver_email
        @contact.user_id = @tyml.sender_id
        @contact.save
        saved = 'single'
      end
    end

    respond_to do |format|
      if saved == 'single'
        format.html { redirect_to @tyml, notice: 'Tyml was successfully created.' }
        format.json { render json: @tyml, status: :created, location: @tyml }
      elsif saved == 'multi'
        format.html { redirect_to @new_tyml, notice: 'Tymls were successfully created.' }
        format.json { render json: @new_tyml, status: :created, location: @new_tyml }
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
    @tyml.archived = params[:archived]
    respond_to do |format|
      if @tyml.save
        unless @tyml.url.include?('http://') || @tyml.url.include?('https://')
          @tyml.url = 'http://' + @tyml.url
        end
        format.html { redirect_to @tyml.url }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tyml.errors, status: :unprocessable_entity }
      end
    end
  end

  def mark_as_read_or_unread
    @tyml = Tyml.find(params[:id])
    @current_user = current_user
    if @tyml.viewed == false
      @tyml.viewed = true
    else
      @tyml.viewed = false
    end
    @tyml.save
    redirect_to dashboard_url
  end

  def archive
    @tyml = Tyml.find(params[:id])
    @current_user = current_user

    if @tyml.archived == false
      @tyml.archived = true
    else
      @tyml.archived = false
    end

    if @tyml.save
      respond_to do |format|
        format.html { redirect_to dashboard_url }
        format.js
      end
    else
      redirect_to dashboard_url
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
