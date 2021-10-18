# frozen_string_literal: true

# detail functionalities for problem 1
module Info1
  def get_place(place)
    fol = Dir.glob('*')
    su_fold = fol.select { |i| i.include?(place[0].upcase) }
    su_fold[0]
  end

  def get_files(str)
    arr = []
    Dir.foreach(str) do |files|
      arr << files
    end
    arr
  end

  def get_year_files(str, arr, year)
    fil = arr.select { |i| i.include? year.to_s }
    arrpaths = []
    fil.each do |i|
      fpath = "#{str}/#{i}"
      arrpaths << fpath
    end
    arrpaths
  end

  def searching_through_files(arrp)
    res = []
    arrp.each do |i|
      File.foreach(i) do |j|
        res << j if j.split(',')[0].split('-')[0].to_i.to_s.size == 4
      end
    end
    res
  end

  def month
    { 1 => 'January', 2 => 'February', 3 => 'March', 4 => 'April', 5 => 'May', 6 => 'June', 7 => 'July',
      8 => 'August', 9 => 'September', 10 => 'Octuber', 11 => 'November', 12 => 'December' }
  end

  def result_high_temp(search_f, months_hash)
    arrday = []
    arrhtem = []
    search_f.each do |i|
      arrday << i.split(',')[0]
      arrhtem << i.split(',')[1].to_i
    end
    ind = arrhtem.index(arrhtem.max)
    month_num = arrday[ind].split('-')[1].to_i
    date = arrday[ind].split('-')[2].to_i
    puts "Heighest: #{arrhtem.max}C on #{months_hash[month_num]} #{date}"
  end

  def result_low_temp(search_f, months_hash)
    arrday = [], arrhtem = []
    search_f.each do |i|
      arrday << i.split(',')[0]
      arrhtem << if i.split(',')[3] == ''
                   1000.to_i
                 else
                   i.split(',')[3].to_i
                 end
    end
    month_num = arrday[arrhtem.index(arrhtem.min)].split('-')[1].to_i
    date = arrday[arrhtem.index(arrhtem.min)].split('-')[2].to_i
    puts "Lowest: #{arrhtem.min}C on #{months_hash[month_num]} #{date}"
  end

  def result_most_humidity(search_f, months_hash)
    arrday = []
    arrhtem = []
    search_f.each do |i|
      arrday << i.split(',')[0]
      arrhtem << i.split(',')[7].to_i
    end
    ind = arrhtem.index(arrhtem.max)
    month_num = arrday[ind].split('-')[1].to_i
    date = arrday[ind].split('-')[2].to_i
    puts "Humid: #{arrhtem.max}% on #{months_hash[month_num]} #{date}"
  end
end

# class for first problem
class FirstReport
  include Info1
  def info(place, year)
    str = get_place(place)
    arr =  get_files(str)
    arrp = get_year_files(str, arr, year)
    search_f = searching_through_files(arrp)
    months_hash = month
    result_high_temp(search_f, months_hash)
    result_low_temp(search_f, months_hash)
    result_most_humidity(search_f, months_hash)
  end
end

# detail functionalities for 2nd problem
module Info2
  def get_place(place)
    fol = Dir.glob('*')
    su_fold = fol.select { |i| i.include? place[0].upcase }
    su_fold[0]
  end

  def get_files(str)
    arr = []
    Dir.foreach(str) do |files|
      arr << files
    end
    arr
  end

  def get_year_files(str, arr, year, month_inp)
    fil = arr.select { |i| i.include?(year.to_s) }
    arrpaths = []
    fil.each do |i|
      fpath = "#{str}/#{i}"
      arrpaths << fpath
    end
    monthdup = month_inp.dup
    monthdup << ('.txt')
    arrpaths.select { |i| i.split('_').include?(monthdup) }
  end

  def searching_through_files(arrp)
    res = []
    arrp.each do |i|
      File.foreach(i) do |j|
        res << j if j.split(',')[0].split('-')[0].to_i.to_s.size == 4
      end
    end
    res
  end

  def result_high_avg_temp(search_f)
    arrhtem = []
    search_f.each do |i|
      arrhtem << i.split(',')[1].to_i
    end
    avg_high_temp = arrhtem.inject { |sum, el| sum + el }.to_f / arrhtem.size
    puts "Heighest Average: #{avg_high_temp.round}C"
  end

  def result_low_avg_temp(search_f)
    arrhtem = []
    search_f.each do |i|
      arrhtem << if i.split(',')[3] == ''
                   1000.to_i
                 else
                   i.split(',')[3].to_i
                 end
    end
    avg_low_temp = arrhtem.inject { |sum, el| sum + el }.to_f / arrhtem.size
    puts "Lowest Average: #{avg_low_temp.round}C"
  end

  def result_avg_humidity(search_f)
    arrhtem = []
    search_f.each do |i|
      arrhtem << i.split(',')[7].to_i
    end
    avg_humidity = arrhtem.inject { |sum, el| sum + el }.to_f / arrhtem.size
    puts "Average Humidity: #{avg_humidity.round}%"
  end
end

# class for Third problem
class SecondReport
  include Info2
  def info(place, year, month_inp)
    str = get_place(place)
    arr =  get_files(str)
    arrp = get_year_files(str, arr, year, month_inp)
    search_f = searching_through_files(arrp)
    result_high_avg_temp(search_f)
    result_low_avg_temp(search_f)
    result_avg_humidity(search_f)
  end
end

require 'colorize'

# detail functionalities for 3rd problem
module Info3
  def get_place(place)
    fol = Dir.glob('*')
    su_fold = fol.select { |i| i.include? place[0].upcase }
    su_fold[0]
  end

  def get_files(str)
    arr = []
    Dir.foreach(str) do |files|
      arr << files
    end
    arr
  end

  def get_year_files(str, arr, year, month_inp)
    fil = arr.select { |i| i.include?(year.to_s) }
    arrpaths = []
    fil.each do |i|
      fpath = "#{str}/#{i}"
      arrpaths << fpath
    end
    monthdup = month_inp.dup
    monthdup << ('.txt')
    arrpaths.select { |i| i.split('_').include?(monthdup) }
  end

  def searching_through_files(arrp)
    res = []
    arrp.each do |i|
      File.foreach(i) do |j|
        res << j if j.split(',')[0].split('-')[0].to_i.to_s.size == 4
      end
    end
    res
  end

  def result_high_temp(search_f)
    arrhtem = []
    search_f.each do |i|
      arrhtem << i.split(',')[1].to_i
    end
    arrhtem
    # avg_high_temp=arrhtem.inject{ |sum, el| sum + el }.to_f / arrhtem.size
    # puts "Heighest Average: #{avg_high_temp.round}C"
  end

  def result_low_temp(search_f)
    arrhtem = []
    search_f.each do |i|
      arrhtem << i.split(',')[3].to_i
    end
    arrhtem
    # avg_low_temp=arrhtem.inject{ |sum, el| sum + el }.to_f / arrhtem.size
    # puts "Lowest Average: #{avg_low_temp.round}C"
  end

  def result_p3(high, low)
    arr_ind = []
    ((1..31).each { |n| arr_ind << n })
    (0..30).each do |i|
      puts " #{arr_ind[i]}" + " #{'+' * high[i].to_i} ".red + "#{high[i].to_i}C "
      puts " #{arr_ind[i]}" + " #{'+' * low[i].to_i} ".blue + "#{low[i].to_i}C "
    end
  end
end

# class for Third problem
class ThirdReport
  include Info3
  def info(place, year, month_inp)
    str = get_place(place)
    arr =  get_files(str)
    arrp = get_year_files(str, arr, year, month_inp)
    search_f = searching_through_files(arrp)
    high = result_high_temp(search_f)
    low = result_low_temp(search_f)
    result_p3(high, low)
  end
end



















# detail functionalities for 3rd problem
module Info4
  def get_place(place)
    fol = Dir.glob('*')
    su_fold = fol.select { |i| i.include? (place[0].upcase) }
    su_fold[0]
  end

  def get_files(str)
    arr = []
    Dir.foreach(str) do |files|
      arr << files
    end
    arr
  end

  def get_year_files(str, arr, year, month_inp)
    fil = arr.select { |i| i.include?(year.to_s) }
    arrpaths = []
    fil.each do |i|
      fpath = "#{str}/#{i}"
      arrpaths << fpath
    end
    monthdup = month_inp.dup
    monthdup << ('.txt')
    arrpaths.select { |i| i.split('_').include?(monthdup) }
  end

  def searching_through_files(arrp)
    res = []
    arrp.each do |i|
      File.foreach(i) do |j|
        res << j if j.split(',')[0].split('-')[0].to_i.to_s.size == 4
      end
    end
    res
  end

  def result_high_temp(search_f)
    arrhtem = []
    search_f.each do |i|
      arrhtem << i.split(',')[1].to_i
    end
    arrhtem
    # avg_high_temp=arrhtem.inject{ |sum, el| sum + el }.to_f / arrhtem.size
    # puts "Heighest Average: #{avg_high_temp.round}C"
  end

  def result_low_temp(search_f)
    arrhtem = []
    search_f.each do |i|
      arrhtem << i.split(',')[3].to_i
    end
    arrhtem
    # avg_low_temp=arrhtem.inject{ |sum, el| sum + el }.to_f / arrhtem.size
    # puts "Lowest Average: #{avg_low_temp.round}C"
  end

  def result_p3(high, low)
    arr_ind = []
    ((1..31).each { |n| arr_ind << n })
    (0..30).each do |i|
      puts " #{arr_ind[i]}" + " #{'+' * high[i].to_i}".red+"#{'+' * low[i].to_i}".blue + " #{ high[i].to_i}C"+ "-" + "#{ low[i].to_i}C "
      # puts " #{arr_ind[i]}" + " #{'+' * low[i].to_i} ".blue + "#{low[i].to_i}C "
    end
  end
end

# class for Third problem
class BonusReport
  include Info4
  def info(place, year, month_inp)
    str = get_place(place)
    arr =  get_files(str)
    arrp = get_year_files(str, arr, year, month_inp)
    search_f = searching_through_files(arrp)
    high = result_high_temp(search_f)
    low = result_low_temp(search_f)
    result_p3(high, low)
  end
end



























# FirstReport.new.info('dubai', 2006)
# SecondReport.new.info('Lahore', 2006, 'Aug')
# ThirdReport.new.info('muree', 2004, 'Aug')

def month
  { 1 => 'Jan', 2 => 'Feb', 3 => 'Mar', 4 => 'Apr', 5 => 'May', 6 => 'Jun', 7 => 'Jul',
    8 => 'Aug', 9 => 'Sep', 10 => 'Oct', 11 => 'Nov', 12 => 'Dec' }
end
case ARGV[0]
when '-e'
  FirstReport.new.info(ARGV[2], ARGV[1])
when '-a'
  mont = month[ARGV[2].to_i]
  SecondReport.new.info(ARGV[3],ARGV[1],mont)
# when '-c'
#   mont = month[ARGV[2].to_i]
#   ThirdReport.new.info(ARGV[3], ARGV[1].to_i, mont)
when '-c'
  puts "#{mont = month[ARGV[2].to_i]} #{ARGV[1]}"
  BonusReport.new.info(ARGV[3], ARGV[1], mont)
end
ARGV.length
