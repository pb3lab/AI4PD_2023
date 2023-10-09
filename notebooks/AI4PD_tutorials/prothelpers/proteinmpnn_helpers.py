def write_fixed_positions_jsonl_single_chain(pdb, residues_to_fix, outfolder):
    '''
    pdb: filepath to the output from diffusion
    residues_to_fix: list of pdb residues to fix (e.g. [1,2,3,...])
    outfolder: dir where to save the .jsonl file
    '''
    import json
    import prody
    prody.confProDy(verbosity='none')

    p = prody.parsePDB(pdb, subset='ca')
    s = p.getSequence()
    model_name = pdb.split('/')[-1][:-4]
    fixed_dict = {}
    fixed_dict[model_name] = {"A": residues_to_fix}
    with open(f"{outfolder}/{model_name}_fixed.jsonl", 'w') as f:
        f.write(json.dumps(fixed_dict))
    return f"{outfolder}/{model_name}_fixed.jsonl"