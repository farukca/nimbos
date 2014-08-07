namespace :export_nimbos do
  desc "Prints Parameter tables in a seeds.rb way."
  task :countries_in_seeds_format => :environment do
    Nimbos::Country.order(:code).all.each do |country|
      puts "Nimbos::Country.create(#{country.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end

  task :listheaders_in_seeds_format => :environment do
  	Nimbos::Listheader.all.each do |listheader|
  		puts "Nimbos::Listheader.create(#{listheader.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
  	end
  end

  task :listitems_in_seeds_format => :environment do
  	Nimbos::Listitem.all.each do |listitem|
  		puts "Nimbos::Listitem.create(#{listitem.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
  	end
  end

end