function opts = nicbodeopt(xlim,yunits,title)
    opts = bodeoptions;
    opts.PhaseWrapping = 'on';
    opts.FreqUnits = 'Hz';
    opts.Grid = 'on';
    opts.MagUnits = 'abs';
    opts.MagScale = 'log';
    
    % text label sizes
    opts.Ylabel.FontSize = 14;
    opts.Xlabel.FontSize = 14;
    opts.Title.FontSize = 14;
    opts.TickLabel.FontSize = 14;
    
    if nargin > 0 && numel(xlim)>0
        opts.XLimMode = 'manual';
        opts.XLim = xlim;
    end
    if nargin > 1
        opts.YLabel.String{1} = ['Magnitude (' yunits ')'];
    end
    if nargin > 2
        opts.Title.String = title;
    end
end