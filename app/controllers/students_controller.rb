class StudentsController < ApplicationController

    #GET/students 
    def index 
        render json: Student.all 
    end


    #GET/students/:id
    def show 
        student = Student.find_by(id: params[:id])
        if student 
            render json: student 
        else
            render json: {error: "Student not found"}, status: :not_found
        end
    end


    #POST/students 
    def create 
        student = Student.create(student_params)
        if student.valid?
            render json: student 
        else
            render json: { errors: "validation errors"}, status: :unprocessable_entity
        end
    end

    private 
    def student_params
        params.permit(:name, :age, :major, :instructor_id)
    end


    #PATCH/students/:id
    def update 
        student = Student.find_by(id: params[:id])
        student.update(student_params)
        if student 
            render json: student 
        else
            render json: {error: "Student not found"}, status: :not_found
        end
    end


    #DELETE/students/:id 

    def destroy 
        student = Student.find_by(id: params[:id])
        student.delete
        head :no_content
    end

    
end
