%classification
Umoi=

[dc, classify]= max(Umoi(:,end).*W(:,end),[],1)

domain = W(:,end);

for i=1:k
squared_diff=fv(:,i);
integral_value (:,i) = trapz(domain, squared_diff);
end