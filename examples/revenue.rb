require 'byebug'
byebug
require 'r_dataset'

RDataset::RDataset.define('Revenue') do
  output_file 'a.csv'
  sample_size 50_000
  include_sample_number false


  columns [
    :number_of_licenses,
    :price_per_license,
    :number_of_hours_consultancy_per_license,
    :hourly_fee,
    :license_revenu,
    :consultancy_revenue,
    :total_revenue
  ]

  rows do
    number_of_licenses                      between(1000, 2000)
    price_per_license                       between(1000, 1500)
    number_of_hours_consultancy_per_license between(0, 16)
    hourly_fee                              between(100,150)
    license_revenu                          number_of_licenses * price_per_license
    consultancy_revenue                     number_of_licenses * number_of_hours_consultancy_per_license * hourly_fee
    total_revenue                           consultancy_revenue + license_revenu
  end
end

