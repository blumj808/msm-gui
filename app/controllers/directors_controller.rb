class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    # params hash looks like this:
    # {"the_title"=>"1", "the_year"=>"2", "the_duration"=>"3", "the_description"=>"4", "the_image"=>"5", "the_director_id"=>"6"}
    d = Director.new
    d.name = params.fetch("query_name")
    d.dob = params.fetch("query_dob")
    d.bio = params.fetch("query_bio")
    d.image = params.fetch("query_image")
    d.save
    redirect_to("/directors")
    # Retrieve the user's inputs from params
    # Create a record in the movie table
    # Populate each column with the user input
    # Save
    # Redirect the user back to the /movies URL
  end
  def destroy
    the_id = params.fetch("an_id")
    matching_records = Director.where({ :id => the_id })
    the_director = matching_records.at(0)
    the_director.destroy
    redirect_to("/directors")
  end

  def update
    # Get the ID out of params
    director_id = params.fetch("director_id")

    # Look up the existing record
    matching_records = Director.where({ :id => m_id })
    the_director = matching_records.at(0)

    # Overwrite each column with the values from user inputs
    the_director.name = params.fetch("the_name")
    the_director.dob = params.fetch("dob")
    the_director.image = params.fetch("the_image")
    the_director.save
    # Save

    the_director.save

    # Redirect to the movie details page
    redirect_to("/directors/#{the_director.id}")
  end

end
