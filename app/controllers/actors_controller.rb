class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end


  def create
    # params hash looks like this:
    # {"the_title"=>"1", "the_year"=>"2", "the_duration"=>"3", "the_description"=>"4", "the_image"=>"5", "the_director_id"=>"6"}
    m = Actor.new
    m.name = params.fetch("query_name")
    m.dob = params.fetch("query_dob")
    m.bio = params.fetch("query_bio")
    m.image = params.fetch("query_image")
    m.save
    redirect_to("/actors")
    # Retrieve the user's inputs from params
    # Create a record in the movie table
    # Populate each column with the user input
    # Save
    # Redirect the user back to the /movies URL
  end
  def destroy
    the_id = params.fetch("an_id")
    matching_records = Actor.where({ :id => the_id })
    the_actor = matching_records.at(0)
    the_actor.destroy
    redirect_to("/actors")
  end
end
