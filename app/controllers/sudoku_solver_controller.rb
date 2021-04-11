class SudokuSolverController < ApplicationController

		before_action :check_length, only: :create


		def create
			input_arr = params[:in_arr]
			res = Solver.new(input_arr).solve
			render json: { data: res }, status: 200
		end

		private

		def check_length
			len = params[:in_arr].length
			unless len == 8 
				render json: { errors: "Not a 9*9 soduku." }, status: :unprocessable_entity
			end
		end

end