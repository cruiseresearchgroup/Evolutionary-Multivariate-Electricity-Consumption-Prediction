% function [TestingAccuracy,elmparamaters]=ELM(train_data,test_data,NumberofHiddenNeurons, ActivationFunction,minbound,maxbound)
function TestingAccuracy=ELM(train_data,test_data,NumberofHiddenNeurons, ActivationFunction)

%%%%%%%%%%% Load training dataset
T=train_data(end,:);
P=train_data(1:end-1,:);
clear train_data;                                   %   Release raw training data array

%%%%%%%%%%% Load testing dataset
% test_data=load(TestingData_File);
TV.T=test_data(end,:);
TV.P=test_data(1:end-1,:);
clear test_data;                                    %   Release raw testing data array

NumberofTrainingData=size(P,2);
NumberofTestingData=size(TV.P,2);
NumberofInputNeurons=size(P,1);

%%%%%%%%%%% Calculate weights & biases

%%%%%%%%%%% Random generate input weights InputWeight (w_i) and biases BiasofHiddenNeurons (b_i) of hidden neurons
InputWeight=rand(NumberofHiddenNeurons,NumberofInputNeurons)*2-1;
BiasofHiddenNeurons=rand(NumberofHiddenNeurons,1);
tempH=InputWeight*P;
clear P;                                            %   Release input of training data 
ind=ones(1,NumberofTrainingData);
BiasMatrix=BiasofHiddenNeurons(:,ind);              %   Extend the bias matrix BiasofHiddenNeurons to match the demention of H
tempH=tempH+BiasMatrix;

%%%%%%%%%%% Calculate hidden neuron output matrix H
switch lower(ActivationFunction)
    case {'sig','sigmoid'}
        %%%%%%%% Sigmoid 
        H = 1 ./ (1 + exp(-tempH));
    case {'sin','sine'}
        %%%%%%%% Sine
        H = sin(tempH);    
    case {'hardlim'}
        %%%%%%%% Hard Limit
        H = double(hardlim(tempH));
    case {'tribas'}
        %%%%%%%% Triangular basis function
        H = tribas(tempH);
    case {'radbas'}
        %%%%%%%% Radial basis function
        H = radbas(tempH);
        %%%%%%%% More activation functions can be added here                
end
clear tempH;                                        %   Release the temparary array for calculation of hidden neuron output matrix H

%%%%%%%%%%% Calculate output weights OutputWeight (beta_i)
OutputWeight=pinv(H') * T';                        % implementation without regularization factor //refer to 2006 Neurocomputing paper

%%%%%%%%%%% Calculate the training accuracy
Y=(H' * OutputWeight)';                             %   Y: the actual output of the training data
    TrainingAccuracy=sqrt(mse(T - Y))  ;             %   Calculate training accuracy (RMSE) for regression case
%       TrainingAccuracy=MSE(T,Y) ;             %   Calculate training accuracy (RMSE) for regression case; modified by Hui Song on 20.09.2015
TrainingAccuracy(2)=sqrt(mse(T - Y));            %   Calculate testing accuracy (RMSE) for regression case
TrainingAccuracy(1)=mse(T - Y);
TrainingAccuracy(3)=mean(abs((T - Y)./T));
clear H;

%%%%%%%%%%% Calculate the output of testing input
tempH_test=InputWeight*TV.P;
clear TV.P;             %   Release input of testing data             
ind=ones(1,NumberofTestingData);
BiasMatrix=BiasofHiddenNeurons(:,ind);              %   Extend the bias matrix BiasofHiddenNeurons to match the demention of H
tempH_test=tempH_test + BiasMatrix;
switch lower(ActivationFunction)
    case {'sig','sigmoid'}
        %%%%%%%% Sigmoid 
        H_test = 1 ./ (1 + exp(-tempH_test));
    case {'sin','sine'}
        %%%%%%%% Sine
        H_test = sin(tempH_test);        
    case {'hardlim'}
        %%%%%%%% Hard Limit
        H_test = hardlim(tempH_test);        
    case {'tribas'}
        %%%%%%%% Triangular basis function
        H_test = tribas(tempH_test);        
    case {'radbas'}
        %%%%%%%% Radial basis function
        H_test = radbas(tempH_test);        
        %%%%%%%% More activation functions can be added here        
end
TY=(H_test' * OutputWeight)';                       %   TY: the actual output of the testing data
TestingA(2)=sqrt(mse(TV.T - TY));            %   Calculate testing accuracy (RMSE) for regression case
TestingA(1)=mse(TV.T - TY);
TestingA(3)=mean(abs((TV.T-TY)./TV.T));
TestingAccuracy=[TestingA TrainingAccuracy];
%  elmparamaters.inputweight=InputWeight;elmparamaters.baisofhiddenneuron=BiasofHiddenNeurons;elmparamaters.outputweight=OutputWeight;
 