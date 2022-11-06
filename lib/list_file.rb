module ListMaker
  class ListFile
    
    @@filename = 'test.html'
    @@pdfname = 'MyLayout.pdf'
    @@stylesname = 'styles.txt'

    @@valid_sections = ['h1', 'h2', 'p', 'hr', 'ol', 'ul', 'cancel', 'title', 'subtitle', 'paragraph', 'horizontal rule', 'bullet list', 'numbered list']

    @@section_map = {
      'title' => 'h1', 
      'subtitle' => 'h2', 
      'paragraph' => 'p',
      'horizontal rule' => 'hr',
      'numbered List' => 'ol',  
      'bullet List' => 'ul', 
      'cancel' => 'cancel'
    }
    
    def initialize
      # locate list file in APP_ROOT
      @filepath = File.join(APP_ROOT, @@filename)
      @pdfpath = File.join(APP_ROOT, @@pdfname)
      @stylespath = File.join(APP_ROOT, @@stylesname)
      if File.exists?(@filepath)
        # confirm that it is readable and writable
        if !File.readable?(@filepath)
          abort("List file exists but is not readable.")
        end
        if !File.writable?(@filepath)
          abort("List file exists but is not writable.")
        end
      else
        # or create a new file in APP_ROOT
        #   Use File.new/open in write mode
        File.open(@filepath, 'a') do |file|
          file << '<!DOCTYPE html>'
          file << "\n"
          file << '<html lang="en">'
          file << "\n"
          file << "<head>"
          file << "\n"
          file <<  '<meta charset="UTF-8">'
          file << "\n"
          file <<  '<meta name="viewport" content="width=device-width,   initial-scale=1.0">'
          file << "\n"
          file <<  '<meta http-equiv="X-UA-Compatible" content="ie=edge">'
          file << "\n"
          file <<  '<title>HTML 5 Boilerplate</title>'
          file << "\n"
          file <<  '<link rel="stylesheet" href="style.css">'
          file << "\n"
          file <<  '<style>'
          file << "\n"
          file << "\n"
          file <<  '</style>'
          file << "\n"
          file <<  '</head>'
          file << "\n"
          file <<  '<body>'
          file << "\n"
          
          
        end
        File.open(@stylespath, 'a') do |file|

        end
        
        if !File.exists?(@filepath)
          abort("List file does not exist and could not be created.")
        end
      end
      # if success, return self, otherwise exit program
      self
    end
    
    def view
      puts "\nView List\n\n".upcase
      # Read from list file
      # Use File.new/open in read mode
      # add numbers next to list items
      file = File.new(@filepath, 'r')
      file.each_line.with_index do |line, i|
        puts "#{i+1}: #{line}"
      end
      file.close
    end
    
    def add

      lines = File.readlines(@filepath)
     
        if lines.last.include? '</html>'
          puts 'This file is already finalized'
          return
        end
      
      
      
      puts "\nAdd some html\n\n".upcase
      # Add item to the end of the list.
      # Use File.new/open in append mode

      puts "Valid Sections:"
      sections = "Title, Subtitle, Paragraph, Horizontal Rule, Numbered List, Bullet List, Cancel"
      puts sections
        
      
      puts ""
      puts "What section do you want to add?"
      print "> "
      new_section_text = gets.chomp.downcase

      until @@valid_sections.include? new_section_text
        puts 'Please choose a valid section'
        print "> "
        new_section_text = gets.chomp
      end

      new_section = @@section_map[new_section_text]


      @just_text = ['h1', 'h2']
      @lists = ['ul', 'ol']

      
      if new_section_text == 'paragraph'
        puts "If adding multiple paragraphs, please replace line breaks with a #"
        text = $stdin.gets

        paragraphs = text.split("#")
        section_arr = []

        paragraphs.each do |item|
          section_arr.push("  <p>#{item}</p> \n")
        end
  
          
          File.open(@filepath, 'a') do |file|
            file << section_arr.join('')
            file << "\n" # Because we used #chomp above
          end
        
      elsif new_section_text == 'title'
        puts "Please type out your title and hit return"
        #if new_section.downcase == 'p'
          #puts "If adding multiple paragraphs, please replace line breaks with a pound sign (#)"
        #end
        print "> "
        text = gets.chomp

        #if new_section.downcase == 'p'
          #paragraphs = text.split("#")
         # section_arr = []

          #paragraphs.each do |item|
          #  section_arr.push("  <p>#{item}</p> \n")
         # end
  
          
          #File.open(@filepath, 'a') do |file|
          #  file << section_arr.join('')
          #  file << "\n" # Because we used #chomp above
          #end
          
        #else
          File.open(@filepath, 'a') do |file|
            file << "<h1> #{text} <h1>"
            file << "\n" # Because we used #chomp above
          end
        #end  
      elsif new_section_text == 'subtitle'
        puts "Please type out your subtitle and hit return"
        #if new_section.downcase == 'p'
          #puts "If adding multiple paragraphs, please replace line breaks with a pound sign (#)"
        #end
        print "> "
        text = gets.chomp

        #if new_section.downcase == 'p'
          #paragraphs = text.split("#")
         # section_arr = []

          #paragraphs.each do |item|
          #  section_arr.push("  <p>#{item}</p> \n")
         # end
  
          
          #File.open(@filepath, 'a') do |file|
          #  file << section_arr.join('')
          #  file << "\n" # Because we used #chomp above
          #end
          
        #else
          File.open(@filepath, 'a') do |file|
            file << "<h2> #{text} <h2>"
            file << "\n" # Because we used #chomp above
          end
        #end 
      elsif new_section_text == 'bullet list'
        puts "list your items for your bullet list in order, seperated by a pound sign (#)"
        print '> '
        list = gets.chomp.split('#')

        section_arr = []
        

        list.each do |item|
          section_arr.push("  <li>#{item}</li> \n")
        end

        
        File.open(@filepath, 'a') do |file|
          file << "<ul>"
          file << "\n" # Because we used #chomp above
          file << section_arr.join('')
          
          file << "</ul>"
          file << "\n" # Because we used #chomp above
        end
      elsif new_section_text == 'numbered list'
        puts "list your items for your numbered list in order, seperated by a pound sign (#)"
        print '> '
        list = gets.chomp.split('#')

        section_arr = []
        

        list.each do |item|
          section_arr.push("  <li>#{item}</li> \n")
        end

        
        File.open(@filepath, 'a') do |file|
          file << "<ol>"
          file << "\n" # Because we used #chomp above
          file << section_arr.join('')
          
          file << "</ol>"
          file << "\n" # Because we used #chomp above
        end  
      elsif new_section_text == 'hr' || new_section_text == 'horizontal rule'
        puts 'adding a horizontal rule'
        File.open(@filepath, 'a') do |file|
          file << "<hr>"
          file << "\n" # Because we used #chomp above
        end
      else
        puts "Okay we won't add anything"
        return
      end

      
      
      #File.open(@filepath, 'a') do |file|
        #file << new_item
        #file << "\n" # Because we used #chomp above
      #end
      self.add
    end

    def finalize
      lines = File.readlines(@filepath)
      
        if lines.last.include? '</html>'
          puts 'This file is already finalized'
          return
        end
        
      
      puts "\nFinalize your html file\n\n".upcase
      # Add item to the end of the list.
      # Use File.new/open in append mode
      puts "Ready to finish up? (yes/no)"
      print "> "
      answer = gets.chomp
      puts answer
      until answer == 'yes' || answer == 'no'
        puts "Please answer yes or no"
        print "> "
        answer = gets.chomp
      end

      if answer.downcase == 'no' 
        return
      else
        File.open(@filepath, 'a') do |file|
        file << "</body>"
        file << "\n" 
        file << "</html>"
        file << "\n" 
      end
      end

      

    end

    def convert

      require "pdfcrowd"
      puts "If converting a document created with this tool, provide the name."
      puts "If converting an external file, please provide the full path."
      file_name = gets.chomp
      temp_arr = file_name.split('/')
      if temp_arr.length > 1
        path = file_name
      else
        path = File.join(APP_ROOT, file_name)
      end

      pdf = temp_arr[temp_arr.length - 1].gsub('html', 'pdf')
      new_pdf_path = File.join(APP_ROOT, pdf)

      lines = File.readlines(path)
     
        unless lines.last.include? '</html>'
          self.finalize
        end

      if File.exists?(new_pdf_path)
        puts "Do you want to overwrite #{pdf}?"
        print "> "
        response = gets.chomp

        until response.downcase == 'yes' || response.downcase == 'no'
          puts "Please answer yes or no."
          print "> "
          response = gets.chomp
        end

        if response.downcase == 'no'
          return
        else
          File.delete(new_pdf_path)
        end


      end

      begin
          # create the API client instance
          client = Pdfcrowd::HtmlToPdfClient.new("jesterfs", "a844c9ad8ca7e4c694c4b786e4b4956b")
          # run the conversion and write the result to a file
          client.convertFileToFile(path, pdf)
      rescue Pdfcrowd::Error => why
          # report the error
          STDERR.puts "Pdfcrowd Error: #{why}"

          # rethrow or handle the exception
          raise
      end

    end


    def convert_to_pdf

      require "pdfcrowd"
  


      

      puts "Please provide the path to your local PDF file and press enter."
      response = gets.chomp
      print "> "
      pdf = response.gsub("'", "")
      temp_arr = pdf.split('/')
      new_name = temp_arr[temp_arr.length - 1].gsub('pdf', 'html')
      
      if File.exists?(new_name)
        puts "Do you want to overwrite #{new_name}?"
        print "> "
        response = gets.chomp

        until response.downcase == 'yes' || response.downcase == 'no'
          puts "Please answer yes or no."
          print "> "
          response = gets.chomp
        end

        if response.downcase == 'no'
          puts 'Please provide a new name'
          print "> "
          res = gets.chomp
          new_name = "#{res}.html"
        else
          path = File.join(APP_ROOT, new_name)
          File.delete(path)
        end


      end

      
      begin
         #create the API client instance
        client = Pdfcrowd::PdfToHtmlClient.new("jesterfs", "a844c9ad8ca7e4c694c4b786e4b4956b")
    
         #run the conversion and write the result to a file
        client.convertFileToFile(pdf, new_name)
      rescue Pdfcrowd::Error => why
           #report the error
          STDERR.puts "Pdfcrowd Error: #{why}"
      
           #rethrow or handle the exception
          raise
      end

    end






    
    def edit(args=[])
      puts "\nEdit a List Item\n\n".upcase
      # get the item position from the args ("edit 3", "edit 7")
      position = args.first.to_i
      if position < 1
        puts "Include the number of the item to edit."
        puts "Example: edit 3"
        return
      end
      # read list file and make sure that item exists
      #   Use File.readlines
      # return not found message if item does not exist
      lines = File.readlines(@filepath)
      if lines[position-1].nil?
        puts "Invalid item position."
        return
      end
      # output text of current list item again
      # ask user to type new text
      puts "Current Text:"
      puts "#{position}: #{lines[position-1]}"

      puts "What section is it?"
      sections = @@valid_sections.join(", ")
      puts sections
      print '> '
      section = gets.chomp

      until @@valid_sections.include? section.downcase
        puts 'Please choose a valid section'
        print "> "
        section = gets.chomp
      end

      puts "Enter the new text and hit return."
      print "> "
      new_item = gets.chomp
      # write list file with the new updated list
      #   Use File.write
      lines[position-1] = "<#{section}>#{new_item}</#{section}> \n"
      data = lines.join
      File.write(@filepath, data)
      puts "List updated."
    end

    def style
      puts "\nEdit a List Item\n\n".upcase
      # get the item position from the args ("edit 3", "edit 7")
      position = 10
      if position < 1
        puts "Include the number of the item to edit."
        puts "Example: edit 3"
        return
      end
      # read list file and make sure that item exists
      #   Use File.readlines
      # return not found message if item does not exist
      lines = File.readlines(@filepath)
      if lines[position-1].nil?
        puts "Invalid item position."
        return
      end
      # output text of current list item again
      # ask user to type new text
      styles = []
      @valid_colors = ["aliceblue", "antiquewhite", "aqua", "aquamarine", "azure", "beige", "bisque", "black", "blanchedalmond", "blue", "blueviolet", "brown", "burlywood", "cadetblue", "chartreuse", "chocolate", "coral", "cornflowerblue", "cornsilk", "crimson", "cyan", "darkblue", "darkcyan", "darkgoldenrod", "darkgray", "darkgrey", "darkgreen", "darkkhaki", "darkmagenta", "darkolivegreen", "darkorange", "darkorchid", "darkred", "darksalmon", "darkseagreen", "darkslateblue", "darkslategray", "darkslategrey", "darkturquoise", "darkviolet", "deeppink", "deepskyblue", "dimgray", "dimgrey", "dodgerblue", "firebrick", "floralwhite", "forestgreen", "fuchsia", "gainsboro", "ghostwhite", "gold", "goldenrod", "gray", "grey", "green", "greenyellow", "honeydew", "hotpink", "indianred", "indigo", "ivory", "khaki", "lavender", "lavenderblush", "lawngreen", "lemonchiffon", "lightblue", "lightcoral", "lightcyan", "lightgoldenrodyellow", "lightgray", "lightgrey", "lightgreen", "lightpink", "lightsalmon", "lightseagreen", "lightskyblue", "lightslategray", "lightslategrey", "lightsteelblue", "lightyellow", "lime", "limegreen", "linen", "magenta", "maroon", "mediumaquamarine", "mediumblue", "mediumorchid", "mediumpurple", "mediumseagreen", "mediumslateblue", "mediumspringgreen", "mediumturquoise", "mediumvioletred", "midnightblue", "mintcream", "mistyrose", "moccasin", "navajowhite", "navy", "oldlace", "olive", "olivedrab", "orange", "orangered", "orchid", "palegoldenrod", "palegreen", "paleturquoise", "palevioletred", "papayawhip", "peachpuff", "peru", "pink", "plum", "powderblue", "purple", "rebeccapurple", "red", "rosybrown", "royalblue", "saddlebrown", "salmon", "sandybrown", "seagreen", "seashell", "sienna", "silver", "skyblue", "slateblue", "slategray", "slategrey", "snow", "springgreen", "steelblue", "tan", "teal", "thistle", "tomato", "turquoise", "violet", "wheat", "white", "whitesmoke", "yellow", "yellowgreen"]
      puts "Pick a color for the background"
      print "> "

      

      background = gets.chomp 

      until @valid_colors.include? background.downcase
        puts "Please pick a valid color."
        print "> "
        background = gets.chomp 
      end

      puts "Pick a color for your H1s"
      print "> "
      h1_color = gets.chomp 

      until @valid_colors.include? h1_color.downcase
        puts "Please pick a valid color."
        print "> "
        h1_color= gets.chomp 
      end

      puts "Pick a color for your H2s"
      print "> "
      h2_color = gets.chomp 

      until @valid_colors.include? h2_color.downcase
        puts "Please pick a valid color."
        print "> "
        h2_color= gets.chomp 
      end

      puts "Pick a color for your paragraphs and list items"
      print "> "
      text_color = gets.chomp 

      until @valid_colors.include? text_color.downcase
        puts "Please pick a valid color."
        print "> "
        text_color= gets.chomp 
      end



      # write list file with the new updated list
      #   Use File.write
      lines[position-1] = "html {background-color: #{background}} h1 {color: #{h1_color}} h2 {color: #{h2_color}} p {color: #{text_color}} li {color: #{text_color}} \n"
      data = lines.join
      File.write(@filepath, data)
      puts "List updated."
    end




    
  end


  
end
