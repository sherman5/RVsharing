#' calculate sharing probability in basic case
#' @keywords internal
#'
#' @description Assume that only one founder can introduce the variant to 
#' the pedigree. Condition on each founder and sum over all resulting
#' probabilities. 
#' @param procPed pedigree that has been through processPedigree()
#' @param useFounderCouples a logical value indicating whether to exploit the interchangeability of the mother and father from founder couples to save computations. Warning! This works only when all founders have only one spouse. Set to FALSE if at least one founder has two or more spouses.
#' @return sharing probability
oneFounderSharingProbSplitting <- function(procPed, useFounderCouples=TRUE)
{
	nf = length(procPed$founders)
	if (useFounderCouples)
	{
		# Identifying founder couples
		fci = apply(procPed$parents,2,function(vec,founder.vec) all(vec %in% founder.vec), founder.vec = procPed$founders)
		founder.couples = unique(t(as.matrix(procPed$parents[,fci])))
		other.founders = procPed$founders[!(procPed$founders%in%founder.couples)]
		f.vec = c(founder.couples[,1],other.founders)
	}
	else f.vec = procPed$founders
		
	# Creating genealogy with procPed
	peddat = data.frame(procPed$id,t(procPed$parents),as.numeric(procPed$ped$sex))
	colnames(peddat) = c("ind","father","mother","sex")
	gen = GENLIB::gen.genealogy(peddat)

	# Find occurence of founders in ancestry of each affected subject
    affByFounder <- founderOccurence(procPed, procPed$affected, procPed$founders)
    #affByFounder = GENLIB::gen.occ(gen,pro=procPed$affected,procPed$founders)
	
    # sum over probs, conditioning on each founder introducing variant
	carrier.sets = list()
	for (i in length(procPed$affected):1)
	carrier.sets = c(carrier.sets, combn(procPed$affected,i,simplify=FALSE))
    carrier.numer <- rep(0,length(carrier.sets))
    carrier.noRV <- 0
    # First loop over the founder couples, using the father as index, then the other founders
    for (f in f.vec) 
    {
    	# Extract subpedigree 
    	subaffected = procPed$affected[affByFounder[rownames(affByFounder)==as.character(f),]>0]
    	subgen = GENLIB::gen.branching(gen,pro=subaffected,ances=f)
    	subped = GENLIB::gen.genout(subgen)
    	# Adding dummy parents
		mb = subped$father>0 & subped$mother==0
		pb = subped$father==0 & subped$mother>0
		for (p in subped$ind[pb]) subped$father[subped$ind==p] = GENLIB::gen.parent(gen,p,output="Fa")
		for (m in subped$ind[mb]) subped$mother[subped$ind==m] = GENLIB::gen.parent(gen,m,output="Mo")
		p.vec = GENLIB::gen.parent(gen,subped$ind[pb],output="Fa")
		m.vec = GENLIB::gen.parent(gen,subped$ind[mb],output="Mo")
		pedtmp=data.frame(ind=c(p.vec,m.vec),father=0,mother=0,sex=c(rep(1,length(p.vec)),rep(2,length(m.vec))))
		subped = rbind(subped,pedtmp)
		
		# Code to follow progression
		cat ("Founder ",f," subped size ",nrow(subped),"\n")
		
		# Recreating a processed ped
		#subprocPed = list('parents'=rbind(subped$father,subped$mother),'id'=subped$ind,'affected'=subaffected,'founders'=which(subped$father == 0))
		subprocPed = processPedigree(kinship2::pedigree(subped$ind,subped$father,subped$mother,subped$sex,subped$ind%in%subaffected))
						
		    # set all founders to 0 (no variant)	 except current founder f	    
	    net <- try(createNetwork(subprocPed))
	    if (class(net)[1]=="try-error") stop("Creation of subpedigree below founder ",procPed$origID[f]," failed.")
	    else
	    {
	    evid = rep('0', length(subprocPed$founders))
	    evid[which(subped$ind==f)] = '1';
	    net <- try(gRain::setEvidence(net, as.character(subprocPed$founders),evid))		
	    if (class(net)[1]=="try-error") stop("Setting founder genotypes of subpedigree below founder ",procPed$origID[f]," failed.")
		
        # compute probabilities
        if (useFounderCouples)
        {
        	if (f %in% founder.couples[,1])
        	{
        		# Multiply probabilities by 2 to account for the mother contribution
        		carrier.noRV <- carrier.noRV + 2*(1 - denomProb(net,subprocPed))
        		carrier.numer <- carrier.numer + 2*sapply(carrier.sets,numerProbSet,net=net, procPed=subprocPed)
        	}
        	else
        	{
        		carrier.noRV <- carrier.noRV + 1 - denomProb(net,subprocPed)
        		carrier.numer <- carrier.numer + sapply(carrier.sets,numerProbSet,net=net, procPed=subprocPed)
        	}
        }
        else
        {
        	carrier.noRV <- carrier.noRV + 1 - denomProb(net,subprocPed)
        	carrier.numer <- carrier.numer + sapply(carrier.sets,numerProbSet,net=net, procPed=subprocPed)
        }
        }
    }
    return(carrier.numer/(nf-carrier.noRV))
}

numerProbSet <- function(carriers,net,procPed)
{
if (all(carriers%in%procPed$origID))
	{
	carriersi = which(procPed$origID%in%carriers)
	rvInCarriers <- sapply(simplify=FALSE, FUN=function(dummy) 1:2,
      X=as.character(carriersi))
    noRvInNonCarriers <- sapply(simplify=FALSE, FUN=function(dummy) 0,
      X=as.character(setdiff(procPed$affected, carriersi)))
    return(marginalProb(net, c(rvInCarriers, noRvInNonCarriers)))
	}
else return (0)
}