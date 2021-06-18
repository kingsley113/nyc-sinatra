class FiguresController < ApplicationController
  # add controller methods

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    # binding.pry
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  post '/figures' do
    # binding.pry
    @figure = Figure.create(params[:figure])

    if !params[:title][:name].empty?
      # binding.pry
      # create new title entry here
      @figure.titles << Title.create(params[:title])
    end

    if !params[:landmark][:name].empty?
      # create new landmark entry here
      # binding.pry
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    redirect "/figures/#{@figure.id}"
  end
  
  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all

    # binding.pry
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    # @original_figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    
    # Update the name
    @figure.name = params[:figure][:name]
    @figure.save

    #Reset the titles array
    @figure.title_ids = [] 
    #Add new titles based on params
    @titles.each do |title| 
      if params[:figure][:title_ids].include?(title.id.to_s)
        @figure.titles << title
      end
    end
    # Create new title and add if form is filled in
    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end

    # Reset landmarks array
    @figure.landmark_ids = []
    # Add new landmarks based on params
    @landmarks.each do |landmark|
      if params[:figure][:landmark_ids].include?(landmark.id.to_s)
        @figure.landmarks << landmark
      end
    end
    # Create new landmark and add if form is filled in
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    
    redirect "/figures/#{@figure.id}"
  end
end
