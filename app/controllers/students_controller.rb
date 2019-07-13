class StudentsController < InheritedResources::Base

  private

    def student_params
      params.require(:student).permit(:name, :user_id_id, :faculty_id)
    end
end

