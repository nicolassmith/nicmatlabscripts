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
    set([htitle,hxlabel,hylabel,gca],'FontSize',20,'LineWidth',3,'FontWeight','bold','FontName'   , 'Times')
    % set thick line widths for curves
    children = get(haxes,'Children');
    isLine = zeros(1,length(children))==1;
    for j = 1:length(children);
        isLine(j) = strcmp(children(j).Type,'line');
    end
    set(children(isLine),'LineWidth',3)
    % white background
    set(get(haxes,'Parent'),'Color','White')
    set(gcf,'Renderer','painters');
end
