format short
clc
clear all
%phase 1 initial matrix
C = [3 5];
A = [1 2; 1 1; 0 1];
b = [2000; 1500; 600];

%phase 2 plotting graphs
y1 = 0:1:max(b);

x21 = (b(1)-A(1,1).*y1)./A(1,2);
x22 = (b(2)-A(2,1).*y1)./A(2,2);
x23 = (b(3)-A(3,1).*y1)./A(3,2);

x21 = max(0, x21);
x22 = max(0, x22);
x23 = max(0, x23);

plot(y1, x21, 'r', y1, x22, 'k', y1, x23, 'g');
xlabel('values of x1');
ylabel('values of x2');
title('graph');
legend('cons 1', 'cons 2', 'cons 3');

%phase 3 find corner points
cx1 = find(y1 == 0);
c1 = find(x21 == 0);

Line1 = [y1(:,[c1 cx1]); x21(:, [c1 cx1])]';

c2 = find(x22 == 0);
Line2 = [y1(:,[c2 cx1]); x22(:, [c2 cx1])]';

c3 = find(x23 == 0);
Line3 = [y1(:,[c3 cx1]); x23(:, [c3 cx1])]';

corpt = unique([Line1; Line2; Line3], 'rows');

sol = [0; 0]
%phase 4 point of intersections
for i = 1:size(A,1)
    for j = i+1:size(A,1)
        l = [A(i,:); A(j,:)];
        m = [b(i); b(j)];
        res = l\m;
        sol = [sol res];
    end
end
pt = sol'

%phase5 all corner points
allpt = [pt; corpt];
points = unique(allpt, 'rows');

f = []
%phase 6 feasible reagion
for i=1:size(points,1)
    cons1 = A(1,1)*points(i,1) + A(1,2)*points(i,2) - b(1)
    cons2 = A(2,1)*points(i,1) + A(2,2)*points(i,2) - b(2)
    cons3 = A(3,1)*points(i,1) + A(3,2)*points(i,2) - b(3)
    if cons1<=0 & cons2<=0 & cons3<=0
        f = [f ; points(i,:)]
    end
end

%phase 7 computing obj fun
z = f*C'

%phase 8 findingg optimal sol
[zmax, zindex] = max(z)
bfs = f(zindex,:)
bfs = [bfs zmax]

%table out
bfs_opt = array2table(bfs);
bfs_opt.Properties.VariableNames(1:size(bfs_opt,2)) = {'opt1', 'opt2', 'value'}
