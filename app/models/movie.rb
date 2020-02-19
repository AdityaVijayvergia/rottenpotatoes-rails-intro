class Movie < ActiveRecord::Base
    def self.all_ratings()
        return ['G', 'PG', 'PG-13', 'R', 'NC-17']
    end
    
    def self.search_rating(r)
        return self.where(rating: r)
    end
end