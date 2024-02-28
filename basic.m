clc 
clear all
%inputs
C = [2 3 4 7];
A = [2 0 -1 4; 1 -2 6 -7]
B = [8; -3];

%finding m and n
m = size(A,1)
n = size(A,2)

%finding non basic solutions
s_no = nchoosek(n,m)
t = nchoosek(1:n,m)

sol = [];

if n>m
    for i = 1:s_no
        y = zeros(n,1)
        t1 = t(i, :)
        d1 = A(:,t(i,:))
        x = A(:, t(i,:))\B
        if all(x>0 & x~=inf & x~=-inf)
            y(t(i,:)) = x
            sol = [sol y]
        end
    end
else
    error('eqn are more then variables');
end

z = C * sol
[zmax, zindex] = max(z)
BFS = sol(:, zindex)

opt = [BFS' zmax]
opt_bfs = array2table(opt)
opt_bfs.Properties.VariableNames(1: size(opt_bfs, 2)) = {'x1', 'x2', 'x3', 'x4', 'values of z'}
