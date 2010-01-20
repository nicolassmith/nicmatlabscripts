function SRSbodeu(M)

subplot(2,1,1)
loglog(M(:,1),abs(M(:,2)))
subplot(2,1,2)
semilogx(M(:,1),180/pi*unwrap(angle(M(:,2))))