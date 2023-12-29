library(optparse)

option_list <- list(
  make_option(c("--metadata"),help="Metadata file"),
  make_option(c("--count_tool"), help = "Tool that was used to count"),
  make_option(c("--mapping_tool"), help = "tool that was used in mapping"),
  make_option(c("--output"), help = "Name of the output count matrix")
)

opt.parser <- OptionParser(option_list = option_list,
                           description="Usage: create-count-matrix.R [options]")

opts <- parse_args(opt.parser)

metadata <- read.table(file = opts$metadata, sep = " ")
colnames(metadata) <- c("sample", "layout", "condition")
count_matrix <- read.table(file = paste0("results/counts/",opts$count_tool,"/counts-", metadata$sample[1],"-", opts$mapping_tool, ".txt"), header=T)
count_matrix <- count_matrix[ ,c(1,7)]
rownames(count_matrix) <- count_matrix$Geneid
count_matrix$Geneid <- NULL
colnames(count_matrix) <- metadata$sample[1]

for (i in 2:nrow(metadata)){
  data <- read.table(file = paste0("results/counts/",opts$count_tool,"/counts-", metadata$sample[i],"-", opts$mapping_tool, ".txt"), header=T)
  
  data <- data[ ,c(1,7)]
  rownames(data) <- data$Geneid
  data$Geneid <- NULL
  colnames(data) <- metadata$sample[i]
  count_matrix <- merge(x = count_matrix ,y = data, by = 'row.names')
  rownames(count_matrix) <- count_matrix$Row.names
  count_matrix$Row.names <- NULL
}

write.table(x = count_matrix, file = opts$output, quote = F)
