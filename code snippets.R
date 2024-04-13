
# Bioconducter ------------------------------------------------------------



# Aşağıdaki örneklerin çalışması için Bioconducter kütüphanesi yüklenmeli
# 


# if (!require("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install(version = "3.18")



# ayrıntılı bilgi için
# https://bioconductor.org/install/ 



## Ensemblveritabannı kullanmak için gerekli kütüphane: biomaRt
# Yüklemek için
# 
# BiocManager::install("biomaRt")



# 1. biomaRt Örneği ---------------------------------------------------------


library(biomaRt)

# Ensembl veritabanına bağlan
 

ensembl <- useEnsembl(biomart = "ensembl", mirror = "useast" , dataset = "hsapiens_gene_ensembl")



# HLA ilişkili genleri al
hla_genes <- getBM(attributes = c('ensembl_gene_id', 'external_gene_name', 
                                  'chromosome_name', 'start_position', 'end_position'), 
                   filters = 'external_gene_name', 
                   values = c('HLA-A', 'HLA-B', 'HLA-C'), 
                   mart = ensembl)

# ilk 6 veriyi göster
head(hla_genes)

  
 
 
 
 


# 2. ipdDb örneği ------------------------------------------------------------

 
 
 # IPD-IMGT/HLA veritabanını kullanmak için gerekli kütüphane: ipdDb
 # Yüklemek için
 # 
 # BiocManager::install("ipdDb")
 
 library(ipdDb)
 
 hla <- loadHlaData()
 # Veritabanındaki tüm lokusları al
 available_loci <- hla$getLoci()
 
 # Lokustaki tüm alelleri al 
 alleles <- hla$getAlleles(available_loci[1])
 alleles <- hla$getAlleles("HLA-A")
 
 # HLA-A*01:01:01:03 alelinin tüm dizilerini DNAStringSet olarak al
 
 sequences <- hla$getReference(alleles)
 sequences <- hla$getReference(c("HLA-A*01:01:01:01", "HLA-A*01:01:01:03" ))
 
# Bu alel için en yakın tam referansı DNAStringSet olarak al
 
closest_complete <- hla$getClosestComplete(alleles[1])
closest_complete <- hla$getClosestComplete("HLA-A*01:01:01:01")
 
# Alel için gen yapısını GRanges nesnesi olarak ol

structures <- hla$getStructure(alleles)
structures <- hla$getStructure(c("HLA-A*01:01:01:01", "HLA-A*01:01:01:03" ))
 
structures
 
 
 
 
 
 
 
 
 