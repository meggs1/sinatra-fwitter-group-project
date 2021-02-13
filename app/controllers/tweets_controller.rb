class TweetsController < ApplicationController

    get '/tweets' do  
        if logged_in?
            @tweets = Tweet.all 
            @user = current_user
            erb :'tweets/index'
        else 
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb :"/tweets/new"
        else
            redirect "/login"
        end
    end


    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            erb :"tweets/show"
        else
            redirect "/login"
        end
    end

    post '/tweets' do
        if !params[:content].empty?
            @tweet = Tweet.create(content: params[:content])
            current_user.tweets << @tweet
        else
            redirect "/tweets/new"
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by(params[:id])
            erb :'/tweets/edit'
        else
            redirect "/login"
        end            
    end

    patch '/tweets/:id' do
        if logged_in? && !params[:content].empty?
            @tweet = Tweet.find_by(params[:id])
            @tweet.update(:content => params[:content])
          else
            redirect to "/tweets/#{params[:id]}/edit"
        end
    end

    delete "/tweets/:id/delete" do
        if logged_in?
            @tweet = Tweet.find_by(params[:id])
            @tweet.delete
            redirect "/tweets"
        else
            redirect "/tweets"
        end

    end

end
