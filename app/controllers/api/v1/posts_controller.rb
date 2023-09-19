class Api::V1::PostsController < ApplicationController

    before_action :authenticate_user!, only: [:create, :update, :destroy]
    before_action :set_post, only: [:show, :update, :destroy]
  
end
