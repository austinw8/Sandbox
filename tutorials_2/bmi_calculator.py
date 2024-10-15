# BMI Calculator
# BMI = (weight in pounds x 703) / (height in inches x height in inches)

weight = int(input("Weight (lbs): "))
height = int(input("Height (in): "))
BMI = round((weight * 703) / (height * height), 2)

if BMI > 0: 
    if (BMI < 18.5): 
        print(str(BMI) + "--> Underweight")
    elif (BMI <= 24.9): 
        print(str(BMI) + "--> Normal weight")
    elif (BMI <= 29.9): 
        print(str(BMI) + "--> Overweight")
    elif (BMI <= 34.9): 
        print(str(BMI) + "--> Obese")
    elif (BMI <= 39.9): 
        print(str(BMI) + "--> Severely Obese")
    else: 
        print(str(BMI) + "--> Morbidly Obese")
else: 
    print("Enter valid input.") 