def count(equation)    
    # use the logic:
    # check if the total of the operand = total of numbers - 1 and total of open parenthesis = close
    # parenthesis
    # if not, return false
    # if the valid_eqs[i] = number -> put inside numbers
    # if the valid_eqs[i] = operand -> put inside operand 
    # (parentheses > multiple and division > add and substraction)
    # shunting-yard algorithm

    # declare variable
    numbers = []
    operand = []

    i = 0
    j = 0
    k = 0

    # the code
    valid_eq = equation.gsub(/((?![0-9\S\.\-\+\*\/\(\)]).)*/,'')
    valid_eqs = valid_eq.split(/(\d\.?\d*)*/).reject(&:empty?)

    # puts valid_eqs

    # check the input
    if valid_eqs.count<=1 and valid_eqs.count%2 == 0
        puts 'Input a valid equation'
    else
        # change each numbers become float
        while i < valid_eqs.count
            if valid_eqs[i]=~ /^\d+$/
                valid_eqs[i] = valid_eqs[i].to_f
                numbers[j] = valid_eqs[i]
                j += 1
            elsif valid_eqs[i]=~/\A-?(\d+)?\.?\d+\Z/
                valid_eqs[i] = valid_eqs[i]
                numbers[j] = valid_eqs[i].to_f
                j += 1
            else
                if operand.count <= 0
                    operand.push(valid_eqs[i])
                elsif operand.count > 0
                    if valid_eqs[i] === "("
                        operand.push(valid_eqs[i])
                    elsif valid_eqs[i] === ")"
                        loop do
                            numbers[j] = operand.pop
                            j+=1
                            if operand[operand.count-1] == "("
                                break
                            end
                        end
                        operand.pop
                    else
                        if operand[operand.count-1] == "("
                            operand.push(valid_eqs[i])
                        else
                            if change_operand_to_number(operand[operand.count-1]) < change_operand_to_number(valid_eqs[i])
                                operand.push(valid_eqs[i])
                            elsif change_operand_to_number(operand[operand.count-1]) > change_operand_to_number(valid_eqs[i])
                                for x in 0..operand.count-1 do
                                    numbers[j] = operand.pop()
                                    j+=1
                                end
                                operand.push(valid_eqs[i])
                            elsif change_operand_to_number(operand[operand.count-1]) == change_operand_to_number(valid_eqs[i])
                                numbers[j] = operand.pop()
                                j += 1
                                operand.push(valid_eqs[i])
                            end
                        end
                    end
                end
            end
            i += 1
            if i == valid_eqs.count
                for x in 0..operand.count-1 do
                    numbers[j] = operand.pop()
                    j+=1
                end
            end
        end
        if result(numbers).to_s[result(numbers).to_s.length-2] === '.'
            if result(numbers).to_s[result(numbers).to_s.length-1] === '0'
                puts "The result is: #{result(numbers).to_s.gsub! '.0', ''}"
            else
                puts "The result is: #{result(numbers)}"
            end
        else
            puts "The result is: #{result(numbers)}"
        end
    end
end

def result(number)
    x = 0
    r = 0
    num1 = 0
    num2 = 0
    counted = []

    while x<number.count 
        if number[x] =~ /[\+\-\*\/\.]/
            if number[x] == '+'
                num1 = counted.pop
                num2 = counted.pop
                r = num2+num1
            elsif number[x] == '-'
                num1 = counted.pop
                num2 = counted.pop
                r = num2-num1
            elsif number[x] == '/'
                num1 = counted.pop
                num2 = counted.pop
                r = num2/num1
            elsif number[x] == '*'
                num1 = counted.pop
                num2 = counted.pop
                r = num2*num1
            end
            counted.push(r)
        else
            counted.push(number[x])
        end
        x+=1
    end
    return counted[0]
end

def change_operand_to_number(operand)
    if operand == '+' or operand == '-'
        return 0
    elsif operand == '*' or operand == '/'
        return 1
    elsif operand == '('
        return -1
    elsif operand == ')'
        return 3
    end
end


# main class
choice = ""

while choice != "exit"
    #print the first 
    puts "calculator\nplease put your equation (type exit to stop the program):"
    choice = gets.chomp!.to_str
    
    case choice
    
    when "exit"
        puts 'Thank you for using the calculator'
        break
    else
        count(choice)
    end
end