class VotesController < ApplicationController
  def index
    rty = params.fetch :rty
    rid = params.fetch :rid
    mark = params.fetch(:mark).to_i
    vote = Vote.find_by resource_type: rty, resource_id: rid
    if vote.nil?
      Vote.create resource_type: rty, resource_id: rid, mark: mark
    else
      vote.update mark: vote.mark+mark
    end
    flash[:notice] = t 'messages.success'
    redirect_back fallback_location: root_path
  end
end
