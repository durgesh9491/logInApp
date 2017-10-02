class SubcommentsController < ApplicationController
  def create
    @subcomment = Subcomment.new(subcomment_params)
    if @subcomment.save
      flash[:success] = 'successfully Replied.'
    else
      flash[:notice] = "Error creating reply !"
    end
    redirect_to :back
  end

 def destroy
    @subcomment = Subcomment.find(params[:id])
    @subcomment.destroy
    redirect_to :back
 end


  private
    def subcomment_params
      params.require(:subcomment).permit(:content,:comment_id)
    end
end

