class Api::V1::SubscriptionsController < ApplicationController
  def index
    @subscriptions = Subscription.all
    if @subscriptions
    render json: {
        subscriptions: @subscriptions
    }
    else
    render json: {
        status: 500,
        errors: ['error']
    }
    end
end


def show_subscriptions
    @subscription = Subscription.where(
      user_id: params[:user_id],
      )
    if @subscription
      render json: {
        subscription: @subscription
      }
    else
      render json: {
        status: 500,
        errors: ['no user subscriptions found']
      }
    end
end

def create
    subscription = Subscription.new(
        user_id: params[:user_id],
        amazon: params[:amazon],
        disney: params[:disney],
        fx: params[:fx],
        hbo: params[:hbo],
        hulu: params[:hulu],
        netflix: params[:netflix],
        showtime: params[:showtime],
        starz: params[:starz],
        tbs: params[:tbs],
        tnt: params[:tnt],
        usa: params[:usa],
    )
    if subscription.save!
        render json: {
          status: :created,
          subscription: subscription
        }
      else 
        render json: {
          status: 500,
        }
      end
end
end
