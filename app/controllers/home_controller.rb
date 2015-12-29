class HomeController < ApplicationController
  def index
    @trade_sum = Biz::AgentTotal.trade_sum
    @client_sum = Biz::AgentTotal.client_sum
    @trade_detail_sum = Biz::AgentTotal.trade_detail_sum
    @new_clients = Biz::AgentTotal.new_clients

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "商户销量分布")
      f.xAxis(categories: ["United States", "Japan", "China", "Germany", "France"])
      f.series(name: "销量排名", yAxis: 0, data: [14119, 5068, 4985, 3339, 2656])

      f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
      f.chart({defaultSeriesType: "column"})
    end


  end
  def profile

  end
end
