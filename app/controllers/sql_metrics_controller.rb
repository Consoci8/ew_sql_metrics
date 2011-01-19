class SqlMetricsController < ApplicationController
  def index
    @metrics = EwSqlMetrics::Metric.all.paginate(:page => params[:page])
  end
  
  def destroy
    @metric = EwSqlMetrics::Metric.find(params[:id])
    @metric.destroy
    redirect_to sql_metrics_url
  end
end