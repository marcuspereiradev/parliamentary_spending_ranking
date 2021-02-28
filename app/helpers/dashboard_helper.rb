module DashboardHelper
  def number_to_currency_br(value)
    number_to_currency(value, :unit => "R$ ", :separator => ",", :delimiter => ".")
  end

  def date_to_br_date(date)
    date.strftime("%d/%m/%Y") unless date.nil?
  end
end
