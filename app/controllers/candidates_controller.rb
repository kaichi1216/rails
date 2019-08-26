class CandidatesController < ApplicationController
    before_action :find_candidate, only: [:show, :edit, :update, :destroy, :vote]

    def index
      @candidates = Candidate.all.order(vote: :desc).page(params[:pages]).per(5)
    end

    def show
      
    end

    def new
      @candidate = Candidate.new
    end
    
    def edit
      
    end

    def vote
      
      # @candidate.update(vote: @candidate.vote + 1)
      Votelog.create(candidate_id: @candidate.id, ip_address: request.remote_ip)
      redirect_to root_path, notice: '投票成功'
      
    end

    def create
      @candidate = Candidate.new(candidate_params)
      if @candidate.save
        redirect_to root_path, notice: "新增候選人成功!"
      else 
        render :new
        # render html: "fail"
      end
      # render html: params
    end

    def update
      if @candidate.update(candidate_params)
        #成功
        redirect_to root_path, notice: "更新成功"
      else
        #失敗
        render :edit
      end
    end

    def destroy
      @candidate.destroy if @candidate
      redirect_to candidates_path, notice: "資料刪除成功"
    end


    def find_candidate
      @candidate = Candidate.find_by(id: params[:id])
    end

    def candidate_params
      params.require(:candidate).permit(:name,:age,:party,:policy,:degree)
    end
end