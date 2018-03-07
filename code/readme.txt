To use this code, you need to: 

1. download the weather data from: https://www.wunderground.com/history/airport/YMML

2. Process the data with different time windows, e.g., DKw is the data with n cells, n means the number of time window settings, for each cell, the matrix is M*N.
 
3.DFactors: environmental data, 1*m cell, n=the number of auxiliary factors, for each m, there are n cells, n is the number time window settings, for each n, it is an M*N matrix, M is respective time window settings, N is the number of samples.

4. Generate a vector which can divide the samples into K-folder, named as Randlabel.
