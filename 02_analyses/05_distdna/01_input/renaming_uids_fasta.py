#renames all fasta files in a directory according to metadata file and columns
#python3 renaming_uids_fasta.py metadata.csv columnoldnames columnnewnames fasta_loc
import os
import sys
import re
#print(len(sys.argv))
csvloc = sys.argv[1]
if (len(sys.argv) >=5) and int(sys.argv[2]):
	oldnames = int(sys.argv[2])
else:
	print("input integer for column with old names in the 3rd argument")
	quit()
if (len(sys.argv) >=5) and int(sys.argv[3]):
	newnames = int(sys.argv[3])
else:
	print("input integer for column with new names in the 4th argument")
	quit()

#print(oldnames, newnames)
db = open(csvloc)
name_hash={}
for line in db:
	line = line.strip()
	db_split = line.split(",")
	name_hash[db_split[oldnames]] = db_split[newnames]
db.close()
#print(name_hash)
#grab all the fasta files in the folder
ls = os.system("ls -1 *.fasta > test.txt")
f = open("./test.txt")


#print(line.strip())
loc = sys.argv[4]
with open(loc) as openfile:
	content = openfile.read()
	content_list = content.split("\n")
	try:
		for key in content_list:
			if(key[0] == ">") and (len(key) !=0):
				key = key[1:]
				if '_-_' in key:
					key = "".join(re.findall(r'(.*)_-_', key))
				print(">", name_hash[key], sep="")
			else:
				print(key)
				#print(key[1:])			
	except:
		print()
		#print("\n".join(content_list))

#python3 renaming_uids_fasta.py metadata_for_renaming_manual_edits.csv 1 3 orf1-mafft.fasta> renamed-fasta/orf1-mafft.fasta
#python3 renaming_uids_fasta.py metadata_for_renaming_manual_edits.csv 1 3 orf2-mafft.fasta> renamed-fasta/orf2-mafft.fasta
#python3 renaming_uids_fasta.py metadata_for_renaming_manual_edits.csv 1 3 orf3-mafft.fasta> renamed-fasta/orf3-mafft.fasta
#python3 renaming_uids_fasta.py metadata_for_renaming_manual_edits.csv 1 3 orf4-mafft.fasta> renamed-fasta/orf4-mafft.fasta
#python3 renaming_uids_fasta.py metadata_for_renaming_manual_edits.csv 1 3 orf5-mafft.fasta> renamed-fasta/orf5-mafft.fasta
#python3 renaming_uids_fasta.py metadata_for_renaming_manual_edits.csv 1 3 trimmed_complete_gb_and_srr-mafft.fasta> renamed-fasta/trimmed_complete_gb_and_srr-mafft.fasta
