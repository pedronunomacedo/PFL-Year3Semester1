testBMI w h
  | (bmi < 18.5)                = "underweight"
  | (bmi >= 18.5 && bmi < 25.0) = "healthy weight"
  | (bmi >= 25.0 && bmi < 30.0) = "overweight"
  | (bmi >= 30.0)               = "obese"
  where bmi = w / (h^2)
