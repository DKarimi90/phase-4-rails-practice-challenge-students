class InstructorsController < ApplicationController
#    wrap_parameters format: []

rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
# rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    
    #GET/instructors 
    def index 
    instructors = Instructor.all 
    render json: instructors 
    end

    #GET/instructors/:id 
    def show 
    instructor = Instructor.find(params[:id])
    render json: instructor, include: :students 
    end

    #POST/instructor 
    def create 
    instructor = Instructor.create(instructor_params)
    if instructor.valid?
        render json: instructor 
    else 
        render json: { errors: "validation errors"}, status: :unprocessable_entity
    end 

    #PATCH/instructor/:id
    def update 
    instructor = Instructor.find(params[:id])
    instructor.update(instructor_params)
    render json: instructor 
    end
    
    
    end

    #DELETE/instructor/:id
    def destroy 
    instructor = Instructor.find_by(id: params[:id])
    instructor.delete
    head :no_content 
    end


    private 
    def instructor_params
        params.permit(:name)
    end

    def render_not_found_response 
        render json: { error: "Instructor Not Found"}, status: :not_found
    end

    # def render_unprocessable_entity_response(invalid)
    #     render json: { errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    # end
end
