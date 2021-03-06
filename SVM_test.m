[heart_scale_label, heart_scale_inst] = libsvmread('heart_scale'); 
model = svmtrain(heart_scale_label,heart_scale_inst);  
[predict_label,accuracy,prob_estimates] = svmpredict(heart_scale_label,heart_scale_inst,model); 

bestcv = 0;
for log2c = -1:3
  for log2g = -4:1
    %-v n: n-fold cross validation mode
    opt = ['-v 5 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
    cv = svmtrain(heart_scale_label, heart_scale_inst, opt);
    if (cv >= bestcv)
      bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
    end
    fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
  end
end

