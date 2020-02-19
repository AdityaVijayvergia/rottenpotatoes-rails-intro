class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
    redirect = false
    
    @ratings = Movie.all_ratings
    if params.key?( 'ratings' )
      @ratings = params[ 'ratings' ].keys
      session[ 'ratings' ] = params[ 'ratings' ]
      
    elsif session.key?( 'ratings' )
      @ratings = session['ratings'].keys
      params['ratings'] = session['ratings']
      redirect = true
    end
    
    @movies = Movie.search_rating(@ratings)
    
    order = ''
    
    if params.key?(:order)
      order = params[:order]
      session[:order] = params[:order]
      
    elsif session.key?(:order)
      order = session[:order]
      params[:order] = session[:order]
      redirect = true
    end
    
    if redirect==true
      redirect_to movies_path(params), :method => :get
    end
    
    @movies= case order
      when "title", "release_date"
        instance_variable_set("@klass_#{order}", "hilite")
        @movies.order(order)
      else
        @movies
      end
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
