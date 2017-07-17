class Mall::StoresController < ApplicationController
  def index
    authorize Mall::Store
    @stores = Mall::Store.with_role(:manager)
  end

  def new
    authorize Mall::Store
    @store = Mall::Store.new format: 'markdown', currency:

  end

  def create
    authorize Mall::Store

  end
end
