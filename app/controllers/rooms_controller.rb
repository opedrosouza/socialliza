# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, except: %i[index new create]
  skip_before_action :verify_authenticity_token  

  def index
    @rooms = Room.paginate(page: params[:page] || 1, per_page: 10 || params[:per_page]).order(created_at: :asc)
  end

  def show
    if params[:schedule].present?
      sche = @room.schedules.find(params[:schedule])
      if sche.user == current_user && sche.starts_at <= DateTime.now && sche.ends_at >= DateTime.now
        render :show
      else
        redirect_to request.referrer, alert: 'Você não pode entrar na sala'
      end
    else
      redirect_to request.referrer, alert: 'Agende um horário'
    end
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new room_params
    respond_to do |format|
      format.html do
        if @room.save
          redirect_to rooms_path, notice: 'Sala criada com sucesso.'
        else
          render :new, alert: 'Não foi possível criar a sala, tente novamente mais tarde.'
        end
      end
      format.json do
        if @room.save
          render json: @room, status: :created
        else
          render json: {
            errors: @room.errors
          }, status: :bad_request
        end
      end
    end
  end

  def edit; end

  def update
    if @room.update room_params
      redirect_to rooms_path, notice: 'Sala atualizada com sucesso.'
    else
      render :edit, alert: 'Algo deu errado, teste novamente mais tarde.'
    end
  end

  def destroy
    redirect_to rooms_path, notice: 'Sala removida com sucesso.' if @room.destroy
  end

  def schedule
    room = Room.find(params[:room_id])
    if Schedule.of_room(room).starts(params[:starts_at]).count == 0 && 
      agenda = current_user.schedules.create(room: room, starts_at: params[:starts_at], ends_at: params[:ends_at])
      render json: agenda, status: :created
    else
      render json: {
        errors: 'Horario reservado'
      }, status: :bad_request
    end
  end

  private
  
  def room_params
    params.require(:room).permit(:name)
  end

  def set_room
    @room = Room.find params[:id]
  end
end
