s = importdata("Stock_data.csv")
data=s.data;
colheaders=s.colheaders;
data(1,1) = 10
returns = zeros(52,10);

for i=2:53
    returns(i-1,:) = (data(i,:) - data(i-1,:)) ./ data(i,:)
end

expected_returns = mean(returns);
covariance_matrix = cov(returns);

H = covariance_matrix;
Aeq = ones(1,10);
beq = 1;
A = [-1*eye(10) ; -1*expected_returns];
for i=1:150
b = [zeros(1,10) -0.0001*i];

[x,fval,exitflag,output,lambda] = quadprog(H,[],A,b,Aeq,beq);

x
fval;
exitflag;
Returns = x'*expected_returns'
Risk = x' * covariance_matrix * x;

plot(Risk,Returns,'r.','MarkerSize',5);
xlabel('Risk'); ylabel('Returns'); title('Markowitz Portfolio Model'); grid on; axis equal;
hold on
end
hold off
