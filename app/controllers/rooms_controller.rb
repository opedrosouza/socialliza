# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, except: %i[index new create]

  def index
    @rooms = Room.all
  end

  def show; end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new room_params
    if @room.save
      redirect_to room_path(@room), notice: 'Sala criada com sucesso.'
    else
      render :new, alert: 'Não foi possível criar a sala, tente novamente mais tarde.'
    end
  end

  def edit; end

  def update
    if @room.update room_params
      redirect_to room_path(@room), notice: 'Sala atualizada com sucesso.'
    else
      render :edit, alert: 'Algo deu errado, teste novamente mais tarde.'
    end
  end

  def destroy
    redirect_to rooms_path, notice: 'Sala removida com sucesso.' if @room.destroy
  end

  private
  
  def room_params
    params.require(:room).permit(:name)
  end

  def set_room
    @room = Room.find params[:id]
  end
end
