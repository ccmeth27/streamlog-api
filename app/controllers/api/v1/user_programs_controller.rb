class Api::V1::UserProgramsController < ApplicationController
  # skip_before_action :verify_authenticity_token
    
  def index
    user_programs = UserProgram.all
      render json: {
        user_programs: user_programs,
      }
  end

  def show
    user_programs = UserProgram.where(params[:user_id])
    if user_programs
      render json: {
        user_programs: user_programs,
      }
    else
      render json: {
        status: 500,
        errors: ['no programs found']
      }
    end
  end

  def movie_watchlist 
    user_programs = UserProgram.where(
      user_id: params[:user_id],
      is_watchlist: 1,
      is_movie: 1,
      )
    if user_programs
      render json: {
        user_programs: user_programs
      }
    else
      render json: {
        status: 500,
        errors: ['no programs found']
      }
    end
  end

  def series_watchlist 
    user_programs = UserProgram.where(
      user_id: params[:user_id],
      is_watchlist: 1,
      is_movie: 0,
    )
    if user_programs
      render json: {
        user_programs: user_programs,
      }
    else
      render json: {
        status: 500,
        errors: ['no programs found']
      }
    end
  end

  def create
    user_program = UserProgram.new(
      user_id: params[:user_id],
      is_seen: params[:is_seen],
      is_rejected: params[:is_rejected],
      is_watchlist: params[:is_watchlist],
      title: params[:title],
      poster: params[:poster],
      release_year: params[:release_year],
      imdb_id: params[:imdb],
      is_movie: params[:is_movie]
    )
    if user_program.save
      render json: {
        status: :created,
        user_program: user_program,
      }
    else 
      render json: {
        status: 500,
        errors: user_program.errors.full_messages
      }
    end
  end

  

  def seen_program
    user_program = UserProgram.find_by(
      user_id: params[:user_id],
      imdb_id: params[:imdb_id],
      )
    user_program.update_attributes(update_params)
    if user_program.save!
      render json: {
        status: :updated,
        user_program: user_program,
      }
    else 
      render json: {
        status: 500,
        errors: user_program.errors.full_messages
      }
    end
  end

  def remove_program
    user_program = UserProgram.find_by(
      user_id: params[:user_id],
      imdb_id: params[:imdb_id],
      )
    user_program.update_attributes(update_params)
    if user_program.save!
      render json: {
        status: :updated,
        user_program: user_program,
      }
    else 
      render json: {
        status: 500,
        errors: user_program.errors.full_messages
      }
    end
  end

  def destroy_seen_program
    user_program = UserProgram.find_by(params[:id])
    user_program.destroy
  end

  def destroy_removed_program
    user_program = UserProgram.find_by(params[:id])
    user_program.destroy
  end

  private

  def update_params
    params.require(:user_program).permit(:user_id, :imdb_id, :is_seen, :is_watchlist, :is_rejected, :poster, :title, :release_year, :is_movie)
  end
end #end of user programs controller
