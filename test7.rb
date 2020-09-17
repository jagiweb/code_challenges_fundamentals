require "time"

file_name = "batches.csv"

def batches_reader(file_name)

    file_content = File.read(file_name).split("\n")
    dates_and_kg = []
    summary = {}
    file_content.shift #deleting headers from content

    file_content.each_with_index{|e, i| 
        dates_and_kg << e.split(",") #each batch
        dates_and_kg[i].delete_at(2) #deleting company name
        dates_and_kg[i].shift #deleting id
        month = Date.parse(dates_and_kg[i][0]).strftime("%B, %Y")

        if summary[month]
            summary[month] += dates_and_kg[i][1].to_f
        else
            summary[month] = dates_and_kg[i][1].to_f
        end        
    }

    export_file = summary.map{|key, value| "#{key} - Total: #{value.round(2)}kg"}

    file_year = Date.parse(dates_and_kg[0][0]).strftime("%Y")
    export_file.unshift("Summary of the year #{file_year} \n") 
    export_file.push("\nResults from file: #{file_name} \n")
    File.write("result-of-#{file_year}.csv", export_file.join("\n")) 
end

batches_reader(file_name)


