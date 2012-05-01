class AdvertisementsController < ApplicationController
  layout 'default'
  before_filter :admin_user, :except => :redirect

  def index
    @ads = Advertisement.paginate(:page => params[:page], :per_page => 100)
  end

  def show
    @ad = Advertisement.find(params[:id])
  end

  def new
    @ad = Advertisement.new
  end

  def create
    @ad = Advertisement.new(params[:advertisement])
    if @ad.save
      flash[:success] = 'Advertisement added'
      redirect_to @ad
    else
      render :new
    end
  end

  def edit
    @ad = Advertisement.find(params[:id])
  end

  def update
    @ad = Advertisement.find(params[:id])
    if @ad.update_attributes(params[:advertisement])
      flash[:success] = 'Advertisement updated'
      redirect_to @ad
    else
      render :edit
    end
  end

  def redirect
    ad = Advertisement.find(params[:id])
    ad.increment!(:hit_count)
    redirect_to ad.referral_url
  end

  def show_stats
    @ads = Advertisement.find(:all, :order => "id")
    render :layout => "default"
  end

  def reset_stats
    Advertisement.update_all("hit_count = 0")
    redirect_to :action => "show_stats"
  end
end