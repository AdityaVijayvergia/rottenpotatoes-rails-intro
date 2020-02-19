class Movie < ActiveRecord::Base
    def self.get_rating_list
      
      sol = {}
  	  self.select(:rating).uniq.each do |movie|
  		result[movie.rating]=1
	  end
  	  sol
    end
end
