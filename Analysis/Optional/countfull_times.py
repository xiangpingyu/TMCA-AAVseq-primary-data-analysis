
import pysam
import argparse

def extract_reads_in_range(bam_file, start_position, end_position, threshold, output_prefix):
 
    with pysam.AlignmentFile(bam_file, "rb") as bam:
        reads_data = {}   

        for read in bam.fetch(contig="co_refcohF8", start=start_position, end=end_position):
            overlap_start = max(read.reference_start, start_position - 1)   
            overlap_end = min(read.reference_end, end_position - 1)   
            overlap = overlap_end - overlap_start + 1

            if overlap / (end_position - start_position + 1) >= threshold:
                if read.query_name not in reads_data:
                    reads_data[read.query_name] = {"sequence": read.query_sequence, "count": 0}
                reads_data[read.query_name]["count"] += 1

    categorized_reads = {}
    # Corrected loop for categorizing reads
    for read_name, data in reads_data.items():
        categorized_reads.setdefault(data["count"], []).append((read_name, data["sequence"]))

    for count, reads in categorized_reads.items():
        with open(f"{output_prefix}_matches_{count}_times.fasta", "w") as out:
            for read.query_name, sequence in reads:
                out.write(f">{read.query_name}\n{sequence}\n")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Extract reads matching to a specific region from BAM.")
    parser.add_argument("bam_file", help="Path to the input BAM file.")
    parser.add_argument("--start", type=int, required=True, help="Start position of the target region.")
    parser.add_argument("--end", type=int, required=True, help="End position of the target region.")
    parser.add_argument("--threshold", type=float, default=1.0, help="Alignment threshold for the match ratio (default=1.0).")
    parser.add_argument("--output_prefix", default="output", help="Prefix for the output FASTA files.")
   
    args = parser.parse_args()
   
    extract_reads_in_range(args.bam_file, args.start, args.end, args.threshold, args.output_prefix)