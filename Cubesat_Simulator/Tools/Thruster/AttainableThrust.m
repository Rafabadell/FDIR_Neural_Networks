%% Set of forces
F1  = A_FEEP(1:3,1);
F2  = A_FEEP(1:3,2);
F3  = A_FEEP(1:3,3);
F4  = A_FEEP(1:3,4);
F5  = A_FEEP(1:3,5);
F6  = A_FEEP(1:3,6);
F7  = A_FEEP(1:3,7);
F8  = A_FEEP(1:3,8);

%% Obtain points of the domain
n = 4;
% x = zeros(n,n,n);
% y = zeros(n,n,n);
% z = zeros(n,n,n);

for i=1:n+1
    for j=1:n+1
        for k=1:n+1
            for l=1:n+1
                for m=1:n+1
                    for p=1:n+1
                        for q=1:n+1
                            for r=1:n+1
                                
                                F = (i-1)/n*F1+(j-1)/n*F2+(k-1)/n*F3+...
                                    (l-1)/n*F4+(m-1)/n*F5+(p-1)/n*F6+...
                                    (q-1)/n*F7+(r-1)/n*F8;
                                
                                x(i,j,k,l,m,p,q,r) = F(1);
                                y(i,j,k,l,m,p,q,r) = F(2);
                                z(i,j,k,l,m,p,q,r) = F(3);
                                
                                
                                
                            end
                        end
                    end
                end
            end
        end
    end
end



x=x(:);
y=y(:);
z=z(:);

P = [x y z];
P = unique(P,'rows');

%% Plot the polyhedran domain
shp=alphaShape(P(:,1),P(:,2),P(:,3),1);
plot(shp,'FaceColor','blue','FaceAlpha',1,'EdgeColor','black','LineWidth',1)
axis equal

xlabel('$F_{x_b}/f_{max}$', 'Interpreter','latex','FontSize',16)
ylabel('$F_{y_b}/f_{max}$', 'Interpreter','latex','FontSize',16)
zlabel('$F_{z_b}/f_{max}$', 'Interpreter','latex','FontSize',16)