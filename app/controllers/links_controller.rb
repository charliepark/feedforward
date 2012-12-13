#encoding: UTF-8

class LinksController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  # GET /links
  # GET /links.json
  def index
    @links = Link.order("created_at DESC")
    @link = Link.new

    respond_to do |format|
      format.html
      format.json { render json: @links }
      format.rss
    end
  end

  # GET /links/1
  # GET /links/1.json
  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @link }
    end
  end

  # GET /links/new
  # GET /links/new.json
  def new
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @link }
    end
  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
    @link.build_podcast if @link.podcast.nil?
    @podcast = @link.podcast
  end

  # POST /links
  # POST /links.json
  def create
    @link = current_user.links.new(params[:link])

    respond_to do |format|
      if @link.save
        format.html { redirect_to links_path, notice: 'Link was successfully created.' }
        format.json { render json: @link, status: :created, location: @link }
      else
        format.html { render action: "new" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /links/1
  # PUT /links/1.json
  def update
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to links_url, notice: "Link was successfully removed" }
      format.json { head :no_content }
    end
  end

  def title
    require 'open-uri'
    open(params[:page]) do |f|
      render text: f.read[/<title>\s*(.*)\s*<\/title>/iu, 1]
    end
  end
end
