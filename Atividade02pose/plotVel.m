function plotVel(fignum,u,omega,color)
persistent ax1 ax2;

if isempty(ax1) || ~isvalid(ax1) || isempty(figure(fignum).CurrentAxes)
    ax1 = axes(figure(fignum));
    ax2 = axes(figure(fignum));

    subplot(2,1,1,ax1); title(ax1,'Velocidade Linear',FontName='Times');
    xlabel(ax1, '$t(s)$',Interpreter='latex');
    ylabel(ax1, '$\nu(m/s)$',Interpreter='latex');
    grid(ax1,'on'); hold(ax1,'on');

    subplot(2,1,2,ax2); title(ax2,'Velocidade Angular',FontName='Times');
    xlabel(ax2, '$t(s)$',Interpreter='latex');
    ylabel(ax2, '$\omega(rad/s)$',Interpreter='latex');
    grid(ax2,'on'); hold(ax2,'on');
end

plot(ax1,u.Time,u.Data,Color=color);
plot(ax2,omega.Time,omega.Data,Color=color);
