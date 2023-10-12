#!/bin/bash
# Here, we're asking diffusion to make a TIM barrel, by providing course-grained specification of the fold
# We specify the output path
# We tell RFdiffusion that we want to do scaffoldguided design, and that we are not making a binder to a target (just a monomer)
# We provide a path to a directory of TIM barrel scaffolds, generated with the helper script
# We generate 10 designs, with a reduced noise scale during inference of 0.5
# We sample additional length to increase diversity of the outputs. Specifically, we mask the loops and insert 0-5 residues (randomly sampled per-loop) into each loop
# We add 0-5 residues (randomly sampled) to the N and the C-terminus
# This will allow the generation of diverse TIM barrels with slightly different length helices and strands

pip install -U -q -r /root/AI4PD_2023/notebooks/AI4PD_tutorials/protein-design-requirements.txt --disable-pip-version-check
cd ~/AI4PD_2023/RFdiffusion && python setup.py install

mkdir example_outputs # let's make a folder here to put our outputs

~/AI4PD_2023/RFdiffusion/scripts/run_inference.py \
inference.output_prefix=example_outputs/binder \
inference.model_directory_path=/root/AI4PD_2023/RFdiffusion/models/ \
inference.input_pdb=/root/AI4PD_2023/pdbs/il7apo.pdb \
inference.schedule_directory_path='./' \
'contigmap.contigs=[80-80/0 A1-196]' \
'ppi.hotspot_res=[A65,A67,A124,A177,A178]' \
inference.num_designs=10 \
denoiser.noise_scale_ca=0.5 \
denoiser.noise_scale_frame=0.5 \