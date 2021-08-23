function Data_Export(rr, Gyros, Gyros_Data, ReWhe, ReWhe_Data, Thrus, Thrus_Data)
Labels=[Gyros, ReWhe, [Thrus; Thrus; Thrus]];
Data=[Gyros_Data.Data, ReWhe_Data.Data, Thrus_Data.Data];
Data=[Labels;Data];
% fid = fopen(['Training_data\TR',num2str(rr),'.txt'],'w');
fid = fopen(['Test_data\TS',num2str(rr),'.txt'],'w');
for ii=1:length(Data(:,1))
    fprintf(fid,'%.6e\t%.6e\t%.6e\t%.6e\t%.6e\t%.6e\t%.6e\t%.6e\t%.6e\t%.6e\t%.6e\t%.6e\t%.6e\t%.6e\t%.6e\t%.6e\t%.6e\t%.6e\n',Data(ii,1),Data(ii,2),Data(ii,3),Data(ii,4),Data(ii,5),Data(ii,6),Data(ii,7),Data(ii,8),Data(ii,9),Data(ii,10),Data(ii,11),Data(ii,12),Data(ii,13),Data(ii,14),Data(ii,15),Data(ii,16),Data(ii,17),Data(ii,18));
end
fid = fclose(fid);
