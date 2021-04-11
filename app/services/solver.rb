class Solver
	attr_accessor :board
	attr_accessor :backtracks

	def initialize(board)
		@backtracks = 0
		@board = board
	end

	def solve
		r_index, c_index = empty_cell

		guess = possible_values(r_index,c_index)

		return unless guess.any?
			
		guess.each do |g|
			board[r_index][c_index] = g
			solve
			
			return board unless empty_cell
			
			@backtracks +=1
			board[r_index][c_index] = 0
		end
	end

	def empty_cell
		r_index = board.index{ |row| row.include?(0)}

		return nil unless r_index

		c_index = board[r_index].index(&:zero?)
		[r_index,c_index]
	end

	def possible_values(r_index,c_index)
		return [] unless [r_index,c_index].any?

		(1..9).each_with_object([]) do |val,res|
			res << val if valid?(r_index,c_index,val)
		end
	end


	def valid?(row,column,guess)
		valid_row?(row, guess) && valid_column?(column, guess) && valid_square?(row,column,guess)
	end

	def valid_row?(row,guess)
		board[row].none?{ |cell| cell == guess }
	end

	def valid_column?(column, guess)
		board.none?{ |row| row[column] == guess }
	end

	def valid_square?(row,column,guess)
		square_x = (row/3)*3
		square_y = (column/3)*3

		(0..2).each do |x_index|
			(0..2).each do |y_index|
				return false if board[square_x +  x_index][square_y + y_index] == guess
			end
		end
		true
	end


end