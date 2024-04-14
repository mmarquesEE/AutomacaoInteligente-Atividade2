function plotTraj(fignum,poseR_list,color)

x = poseR_list.Data(:,1);
y = poseR_list.Data(:,2);
phi = poseR_list.Data(:,3);

persistent ax;

if isempty(ax) || ~isvalid(ax) || isempty(figure(fignum).CurrentAxes)
    ax = figure(fignum).CurrentAxes;
    if isempty(ax)
        ax = axes(figure(fignum));
    end
    
    axis(ax,'equal'); grid(ax,'on'); hold(ax,'on');
    title(ax,'Trajetória',FontName='Times');
    xlabel(ax,'$x(m)$',Interpreter='latex');
    ylabel(ax,'$y(m)$',Interpreter='latex');
end

plot(ax,x,y,'--',Color=color);

r = polyshape([-0.1 -0.1 0.2],[-0.1 0.1 0]);
L = length(x);

for i = 1:L
    if(i==1 || i==floor(L/10) || i==L)
        r1 = translate(rotate(r,(180/pi)*phi(i)),[x(i), y(i)]);
        plot(ax,r1,FaceColor=color);
    end
end


