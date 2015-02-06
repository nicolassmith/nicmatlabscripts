function varargout = grabdata(channels,t0,duration)
    
    % klist shows kerberos tickets
    % kinit gets a new ticket

    conn = nds2.connection('nds.ligo.caltech.edu', 31200);

    conn.iterate(t0,t0+duration,channels);
    buffers = conn.next();

    for jj = 1:length(channels)

        rate = buffers(jj).getChannel().getSampleRate();
        buflength = buffers(jj).getLength();

        t = (1:buflength)/rate;
        data = buffers(jj).getData();

        varargout{jj} = struct('t',t,'data',double(data),'rate',rate); %#ok<AGROW>
    end

    while conn.hasNext()
        buffers = conn.next();
        for jj = 1:length(channels)
            varargout{jj}.data = [varargout{jj}.data; double(buffers(jj).getData())]; %#ok<AGROW>
        end
    end
end