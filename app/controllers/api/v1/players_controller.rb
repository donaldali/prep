class API::V1::PlayersController < API::ApiController

  def show
    @player = Player.find_by(id: params[:id])
    # render json: @player.as_json( only: [:name, :number] )

    # render json: @player
    respond_to do |format|
      if @player.nil?
        format.json { render json: "Player not found", status: :not_found }
        format.xml { render xml: "Player not found", status: :not_found }
      else
        format.json { render json: @player }
        format.xml { render xml: @player }
        # format.xml { render xml: @player.to_xml(:only => :name) }
      end
    end
  end

  def index
    page = (params[:page] || 1).to_i
    per_page = (params[:per_page] || 5).to_i
    @players = Player.offset(per_page * (page - 1)).limit(per_page)

    respond_to do |format|
      format.json { render json: @players }
      format.xml { render xml: @players }
      # format.xml { render xml: @players.to_xml(:include => :name)}
    end
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      render json: @player, status: :created
    else
      render json: @player.errors.full_messages, status: :unprocessable_entity     
    end
  end

  def update
    @player = Player.find_by(id: params[:id])

    if @player.nil?
      render json: "Player not found.", status: :not_found
    elsif @player.update(player_params)
      render json: @player, status: :ok
    else
      render json: @player.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @player = Player.find_by(id: params[:id])

    if @player.nil?
      render json: "Player not found", status: :not_found
    else
      @player.destroy
      head :no_content
    end

  end


  private


  def player_params
    params.require(:player).permit(:name, :country, :number)
  end

end
