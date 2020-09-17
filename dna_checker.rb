require './chromosome_checker'

class DnaChecker
    
    @file_name = "dna.in"
    @chromosome_checker = ChromosomeChecker.new

    def self.process_file(file_name)
        if !File.exists?(file_name)
            p "Please add a dna.in file in the app directory"
            return 0, []
        else
            file_content = File.read(file_name).split
            num_of_chromosomes = file_content.shift
            return num_of_chromosomes.to_i, file_content
        end
    end

    def self.validate_chromosome(chromosome, index)
        if @chromosome_checker.validate_chromosome(chromosome)
            return "CASE #{index}: YES"
        else
            return "CASE #{index}: NO"
        end
    end

    def self.generate_output_file(chromosomes_output)
        chromosomes_output.unshift("DNA OUTPUT")
        chromosomes_output.push("END OF OUTPUT")
        File.write("dna.out", chromosomes_output.join("\n"))
    end
    
    num_of_chromosomes, chromosomes = process_file(@file_name)

    if num_of_chromosomes < 1 || num_of_chromosomes > 100
        p "the number of chromosomes needs to be between 1 and 100"
    end
    if num_of_chromosomes != chromosomes.length
        p "the number of chromosomes (first line of #{@file_name}) does not match the number of data inputs in the file"
    else
        chromosomes_output = chromosomes.each_with_index.map{ |chromosome, index|  validate_chromosome(chromosome, index + 1)}
        generate_output_file(chromosomes_output)
    end
end