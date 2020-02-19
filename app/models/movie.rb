class Movie < ActiveRecord::Base
    def self.all_ratings()
        return ['G', 'PG', 'PG-13', 'R', 'NC-17']
    end
    
    def self.with_ratings(ratings)
        return self.where(rating: ratings)
    end
end