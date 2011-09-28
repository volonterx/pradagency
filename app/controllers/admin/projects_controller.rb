class Admin::ProjectsController < ApplicationController
  before_filter :find_project, :only => [:edit, :update, :destroy, :sort]
  
  def index
    @projects = Project.all(:order => "created_at ASC")
  end

  def new
    @project = Project.new
    @project.images.build
    @image_counter = 0
  end

  def create
    @project = Project.new(params[:project])
    if @project.save 
      redirect_to admin_projects_path, :notice => "Проект успешно добавлен" 
    else 
      render :action => "new"
    end
  end

  def edit
    @image_counter = @project.images.size
    @images = @project.images.order('images.position ASC')
  end

  def update
    if @project.update_attributes(params[:project])
      if params[:delete_ids] != nil
        delete_ids = params[:delete_ids]
        delete_ids.each do |del|
          image = @project.images.find_by_id(del)
          image.destroy
        end
      end
     redirect_to admin_projects_path, :notice => "Проект успешно отредактирован"
    else
     render :action => "edit"
    end
  end

  def destroy
    if @project.delete
      notice = "Проект успешно удален"
    else
      notice = "С удалением что-то не так"
    end
    redirect_to admin_projects_path, :notice => notice
  end

  def sort
    @images = @project.images.all
    @images.each do |image|

      image.update_attribute(:position, params['image'].index(image.id.to_s) + 1)
  end

  render :nothing => true
  end
  
  private
  
  def find_project
    @project = Project.find(params[:id])
  end
end
