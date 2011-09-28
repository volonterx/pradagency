class Admin::ProjectsController < ApplicationController
  before_filter :find_project, :only => [:edit, :update, :destroy]
  
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
      redirect_to admin_projects_path
      notice = "Проект успешно добавлен" 
    else 
      render :action => "new"
    end
  end

  def edit
    @image_counter = @project.images.size
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
     redirect_to admin_projects_path
     notice = "Проект успешно отредактирован"
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
    redirect_to admin_projects_path
  end

  def reorder
      if request.xhr?
        new_order = params[:order].split("&").map{|t| t.split("=").last}
        Image.find_all_by_post_id(params[:project_id], :order => "position ASC").each do |p|
          p.update_attribute(:position, new_order.index(p.id.to_s))
        end
        respond_to do |wants|
          wants.js
        end
      else
        render :text => "<h1>Who are you, Mr.?</h1>"
      end
  end

  private
  
  def find_project
    @project = Project.find(params[:id])
    
  end
end
