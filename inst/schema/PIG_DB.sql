CREATE TABLE IF NOT EXISTS id_accession AS
SELECT DISTINCT
    genes.gene_id AS entrez,
    accessions.accession AS accnum,
    refseq.accession AS refseq
FROM genes
JOIN accessions ON genes._id = accessions._id
LEFT OUTER JOIN refseq ON genes._id = refseq._id
    AND refseq.accession = accessions.accession;
    
CREATE INDEX IF NOT EXISTS entrez_accession on id_accession (entrez);

CREATE TABLE IF NOT EXISTS id_transcript AS
SELECT DISTINCT
    genes.gene_id AS entrez,
    unigene.unigene_id AS unigene
FROM genes
JOIN unigene ON genes._id = unigene._id;

CREATE INDEX IF NOT EXISTS entrez_transcript on id_transcript (entrez);

CREATE TABLE IF NOT EXISTS id AS
SELECT DISTINCT
    genes.gene_id AS entrez,
    gene_info.symbol AS symbol,
    gene_info.gene_name AS genename,
    alias.alias_symbol AS alias
FROM genes
JOIN gene_info ON genes._id = gene_info._id
LEFT OUTER JOIN alias ON genes._id = alias._id;

CREATE INDEX IF NOT EXISTS entrez_id on id (entrez);

CREATE INDEX IF NOT EXISTS symbol_id on id (symbol);

CREATE TABLE IF NOT EXISTS id_pm AS
SELECT DISTINCT
    genes.gene_id AS entrez,
    pubmed.pubmed_id AS pmid
FROM genes
JOIN pubmed ON genes._id = pubmed._id;

CREATE INDEX IF NOT EXISTS entrez_pm on id_pm (entrez);

CREATE TABLE IF NOT EXISTS id_protein AS
SELECT DISTINCT
    genes.gene_id AS entrez,
    ec.ec_number AS enzyme,
    uniprot.uniprot_id AS uniprot
FROM genes
LEFT OUTER JOIN ec ON genes._id = ec._id
LEFT OUTER JOIN uniprot ON genes._id = uniprot._id;
    
CREATE INDEX IF NOT EXISTS entrez_protein on id_protein (entrez);

CREATE TABLE IF NOT EXISTS id_go AS
SELECT DISTINCT
    genes.gene_id AS entrez,
    go.go_id AS go,
    go.evidence AS evidence,
    go.ontology AS ontology
FROM genes
JOIN go ON genes._id = go._id;

CREATE INDEX IF NOT EXISTS entrez_go on id_go (entrez);

CREATE TABLE IF NOT EXISTS id_go_all AS
SELECT DISTINCT
    genes.gene_id AS entrez,
    go_all.go_id AS goall,
    go_all.evidence AS evidenceall,
    go_all.ontology AS ontologyall
FROM genes
LEFT OUTER JOIN go_all ON genes._id = go_all._id;

CREATE INDEX IF NOT EXISTS entrez_go_all on id_go_all (entrez);

CREATE TABLE IF NOT EXISTS metadata_org AS
SELECT * FROM metadata;
