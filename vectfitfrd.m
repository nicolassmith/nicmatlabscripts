function zpksys=vectfitfrd(frd,Npoles,fitrange)
    % sys = fitfrd(frd,Npoles,fitrange)

    if nargin < 2
        Npoles = 8;
    end

    % Npoles must be even
    if mod(floor(Npoles),2)
        Npoles = Npoles + 1;
    end
    
    if nargin > 2
        frd = fselect(frd,fitrange(1),fitrange(2));
    end
    
    roundMag = 1e6;
    Niter = 20;
    
    opts.relax=1;      %Use vector fitting with relaxed non-triviality constraint
    opts.stable=1;     %Enforce stable poles
    opts.asymp=1;      %Include both D, E in fitting
    opts.skip_pole=0;  %Do NOT skip pole identification
    opts.skip_res=0;   %Do NOT skip identification of residues (C,D,E)
    opts.cmplx_ss=1;   %Create complex state space model
    
    opts.spy1=0;       %No plotting for first stage of vector fitting
    opts.spy2=0;       %Create magnitude plot for fitting of f(s)
    opts.logx=1;       %Use logarithmic abscissa axis
    opts.logy=1;       %Use logarithmic ordinate axis
    opts.errplot=1;    %Include deviation in magnitude plot
    opts.phaseplot=1;  %Also produce plot of phase angle (in addition to magnitiude)
    opts.legend=1;     %Do include legends in plots
    
    [Tdata,f]=frdata(frd);
    T = squeeze(Tdata).';
    s = 2i*pi*f;
    
    %Initial poles for Vector Fitting:
    poles=-logspace(log10(min(s)),log10(max(s)),Npoles); %Initial poles
    
    weight=1./abs(T); %scaled weighting
    
    % loop over vectfit
    for j = 1:Niter
        [SER,poles,~,~]=vectfit4(T,s,poles,weight,opts);
    end
    
    A = full(SER.A);
    B = SER.B;
    C = SER.C;
    D = SER.D;
    
    %% Get real world zeros and poles out of state space model
    zpksys = zpk(ss(A,B,C,D));
    [z,p,k] = zpkdata(zpksys);
    
    % remove small complex parts
    z = round(z{1}*roundMag)/roundMag;
    p = round(p{1}*roundMag)/roundMag;
    k = round(k*roundMag)/roundMag;
    
    % package for output
    zpksys = zpk(z,p,k);
    zpksys.Name = 'Fit';
    if ~isempty(frd.Name)
        zpksys.Name = [zpksys.Name ' of ' frd.Name];
    end
end