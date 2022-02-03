#!/usr/bin/env Rscript
suppressMessages(require(dplyr))
suppressMessages(require(ggplot2))
suppressMessages(require(reshape2))
suppressMessages(require(ggbeeswarm))
suppressMessages(require(optparse))
source('qPCR_processing.R')
option_list = list(
  make_option(c("-q", "--cqfile"), type="character", default=NULL, 
              help="The Cq file from BioRad qPCR machine", metavar="character"),
  make_option(c("-m", "--metadata"), type="character", default=NULL, 
              help="A metadata file to assign your samples into groups", metavar="character"),
  make_option(c("-g", "--refgene"), type="character", default=NULL,
              help="The gene used for normalization", metavar="character"),
  make_option(c("-s", "--refsample"), type="character", default=NULL, 
              help="The sample used as reference sample", metavar="character"),
  make_option(c("-n", "--name"), type="character", default=NULL, 
              help="The output file name", metavar="character")
); 
opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);

if(is.null(opt$cqfile))
  stop("The qPCR run file is missing. Please define the path to the file (e.g. -q /home/user/someguy/qPCR.csv)!")

if(is.null(opt$metadata))
  stop("The meta data file is missing. Please create it and define the path to the file (e.g. -m /home/user/someguy/metadata.csv)!")

if(is.null(opt$refgene))
  stop("The refence gene is missing. What is the gene as reference in this run (e.g. -g GAPDH)?")

if(is.null(opt$refsample))
  stop("The sample used for calibration is missing. Please choose one of the samples in this run as calibrator (e.g. -s Ctrl1)?")

if(is.null(opt$name))
  stop("File name is not defined. Please give a name to your output files (e.g. -n test)!")

suppressMessages(qPCR_processing(qPCR_file = opt$cqfile, metadata_file = opt$metadata,ref_gene = opt$refgene, ref_sample = opt$refsample, file_name=opt$name))
print("Succeed! Please check the output files!")
