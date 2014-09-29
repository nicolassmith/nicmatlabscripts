function makeAxesPretty(haxes)

    if nargin<1
        haxes = gca;
    end

    htitle = get(haxes,'Title');
    hxlabel = get(haxes,'XLabel');
    hylabel = get(haxes,'YLabel');
    
    % make a grid
    grid on
    % set fonts for labels and tick marks
    set([htitle,hxlabel,hylabel,gca],'FontSize',25,'LineWidth',3,'FontWeight','bold')
    % set thick line widths for curves
    set(get(haxes,'Children'),'LineWidth',3)
    % white background
    set(get(haxes,'Parent'),'Color','White')

end