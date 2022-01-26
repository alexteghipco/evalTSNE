function [sIndex,optimalSPerplexity, optimalKLPerplexity] = evalTsne(perplexity,KLVals,nSamples,plotSwitch)
% Evaluates solution divergence values (Kullback-Leiber) across tSNE models
% with varying perplexities. Divergence decreases with perplexity. This
% result in the selection of the highest tested perplexity value. By
% weighting divergence by the magnitude of perplexity, the S index can
% select the lowest perplexity value that minimizes divergence

sIndex = (log(nSamples).*(perplexity/nSamples) + (KLVals.*2));
[minVal, minIdx] = min(sIndex);
optimalSPerplexity = perplexity(minIdx);
[minVal2, minIdx2] = min(KLVals);
optimalKLPerplexity = perplexity(minIdx2);

switch plotSwitch
    case 'true'
        % plot lines
        figure
        h = plot(perplexity,sIndex,'--','Color',[1 0.4 0.2]);
        hold on
        i = plot(perplexity,KLVals,'Color',[0 0.8 0.8]);
        
        % plot optimals
        j = plot(optimalSPerplexity,sIndex(minIdx),'LineStyle','none','Color',[1 0.4 0.2],'Marker','o','MarkerSize',10,'MarkerFaceColor',[1 0.4 0.2]);
        k = plot(optimalKLPerplexity,KLVals(minIdx2),'LineStyle','none','Color',[0 0.8 0.8],'Marker','o','MarkerSize',10,'MarkerFaceColor',[0 0.8 0.8]);
        
        % beautify with labels and properties
        ax = gca;
        ax.TickLength = [0 0];
        set(gcf,'color','w');
        box off
                
        xlabel('Perplexity')
        ylabel('Divergence')
        title('Evaluation of optimal perplexity based on divergence of solution from original data')
        legend('S-index divergence','KL divergence','optimal perplexity based on S','optimal perplexity based on KL')
        
end



