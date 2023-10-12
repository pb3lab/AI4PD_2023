#!/bin/bash
# Here, we're running one of the motif-scaffolding benchmark examples
# Specifically, we're scaffolding site 5 from RSV-F protein
# We specify the output path and input pdb (the RSV-F protein)
# We specify the protein we want to build, with the contig input:
#   - 10-40 residues (randomly sampled)
#   - residues 163-181 (inclusive) on the A chain of the input
#   - 10-40 residues (randomly sampled)
# We generate 10 designs

pip install -U -q -r /root/AI4PD_2023/notebooks/AI4PD_tutorials/protein-design-requirements.txt --disable-pip-version-check
cd ~/AI4PD_2023/RFdiffusion && python setup.py install
cd ~/AI4PD_2023/design_examples/RFdiffusion_examples/

mkdir example_outputs # let's make a folder here to put our outputs

~/AI4PD_2023/RFdiffusion/scripts/run_inference.py \
inference.output_prefix=example_outputs/design_motifscaffolding \
inference.input_pdb=./input_pdbs/5TPN.pdb \
'contigmap.contigs=[10-40/A163-181/10-40]' \
inference.num_designs=10 \
inference.model_directory_path=/root/AI4PD_2023/RFdiffusion/models/ \
inference.schedule_directory_path='./' 
