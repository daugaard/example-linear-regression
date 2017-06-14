require 'csv'
require 'ruby_linear_regression'

x_data = []
y_data = []
# Load data from CSV file into two arrays - one for independent variables X and one for the dependent variable Y
# Each row contains square feet for property and living area like this: [ SQ FEET PROPERTY, SQ FEET HOUSE ]
CSV.foreach("./data/staten-island-single-family-home-sales-2015.csv", :headers => true) do |row|
  x_data.push( [row[0].to_i, row[1].to_i] )
  y_data.push( row[2].to_i )
end

## Example 1 - train using normal equation (Fast)
# Create regression model
linear_regression = RubyLinearRegression.new
# Load training data
linear_regression.load_training_data(x_data, y_data)

# Train the model using the normal equation
linear_regression.train_normal_equation


## Example 2 - train using gradient descent (Slow)
# Create regression model
linear_regression_gradient_descent = RubyLinearRegression.new
# Load training data
linear_regression_gradient_descent.load_training_data(x_data, y_data)

linear_regression_gradient_descent.train_gradient_descent(0.0005, 500, true)

# Output cost to compare
puts "Cost Normal Equation: #{linear_regression.compute_cost}, Cost Gradient Descent: #{linear_regression_gradient_descent.compute_cost}"

# Output predictions
# Predict the price of a 2000 sq feet property with a 1500 sq feet house
prediction_data = [2000, 1500]
predicted_price = linear_regression.predict(prediction_data)
puts "Predicted price using normal equation for a 1500 sq feet house on a 2000 sq feet property: #{predicted_price.round}$"

# Predict the price of a 2000 sq feet property with a 1500 sq feet house
prediction_data = [2000, 1500]
predicted_price = linear_regression_gradient_descent.predict(prediction_data)
puts "Predicted price using gradient descent for a 1500 sq feet house on a 2000 sq feet property: #{predicted_price.round}$"
