class LandmarksController < ApplicationController
  # add controller methods

  get '/landmarks' do
    @landmarks = Landmark.all
    # binding.pry
    erb :'landmarks/index'
  end

  get '/landmarks/new' do
    @landmarks = Landmark.all
    # binding.pry
    erb :'landmarks/new'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/show'
  end

  post '/landmarks' do
    # binding.pry
    @landmark = Landmark.create(params[:landmark])
    # binding.pry
    redirect "/landmarks/#{@landmark.id}"
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])

    erb :'landmarks/edit'
  end

  patch '/landmarks/:id' do
    # binding.pry
    @landmark = Landmark.find(params[:id])
    @landmark.name = params[:landmark][:name]
    @landmark.year_completed = params[:landmark][:year_completed]
    @landmark.save

    redirect "/landmarks/#{@landmark.id}"
  end
end
