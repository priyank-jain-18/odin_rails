class UsersController < ApplicationController
    def index
	    @name = "an index action"
    end

    def show
    	@name = "a show action"
    end

    def new    	
    	@name = "a new action"
    end

    def edit
    	@name = "an edit action"
    end

    def create
    end
end