class SqlMetricsController < ApplicationController
  before_filter :check_auth
  
  def index
    @metrics = EwSqlMetrics::Metric.all.descending(:created_at).paginate(:page => params[:page])
  end
  
  def destroy
    @metric = EwSqlMetrics::Metric.find(params[:id])
    @metric.destroy
    redirect_to sql_metrics_url
  end
  
  private
  
  def check_auth
    request.env["warden"].authenticate!
  end
  
end