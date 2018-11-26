class TasksController < ApplicationController
    before_action :set_task, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    
    def index
        if params[:search]
            @tasks = Task.where("title like ?", "%#{params[:search]}%").paginate(page: params[:page], per_page: 3)
        else 
            @tasks = Task.paginate(page: params[:page], per_page: 3)
        end
    end

    def new
        @task = Task.new
    end

    def edit
    end

    def create
        @task = Task.new(task_params)
        @task.user = current_user
        if @task.save
             flash[:success] = "Task was successfully created"
             redirect_to task_path(@task)
         else
             render 'new'
        end
    end

    def update
        if @task.update(task_params)
            flash[:success] = "Task was successfully updated"
            redirect_to task_path(@task)
        else
            render 'edit'
        end
    end

    def show
    end

    def destroy
        @task.destroy
        flash[:danger] = "Task was successfully destroyed"
        redirect_to tasks_path
    end


    private
        def set_task
          @task = Task.find(params[:id])
        end

        def task_params
            params.require(:task).permit(:title, :description, :due_date)
        end
        

        def require_same_user
            # add ... and !current_user.admin?
          if current_user != @task.user and !current_user.admin?
            flash[:danger] = "You can only edit or delete tasks you've set"
            redirect_to root_path
          end
        end

end
