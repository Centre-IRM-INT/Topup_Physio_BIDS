import os
import json
import glob

# Read subjects and sessions from the config file
with open('../Topup_Physio_BIDS/subjects_to_process.cfg', 'r') as config_file:
    # Read the content of the file
    content = config_file.read()

# Extract study, list_sub, list_ses, and STIM values from the content
study = content.split("study=")[1].split("\n")[0].strip()
list_sub = content.split('list_sub="')[1].split('"')[0].strip()
list_ses = content.split('list_ses="')[1].split('"')[0].strip()
STIM = content.split('STIM="')[1].split('"')[0].strip()



EXPDIR = f'/Users/jsein/Documents/Centre_IRMf/DATA/BIDS/{study}'
#EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study

for sub in list_sub.split():
    sub = f'sub-{sub}'
    ses = f'ses-{list_ses}'
    print(f'-----starting subject {sub}_{ses}------')
    SUBDIR = os.path.join(EXPDIR, sub)

    for i in range(len(glob.glob(os.path.join(SUBDIR, f'{ses}/fmap/*dir-AP*.json')))):
        epi = None
        for file in os.listdir(os.path.join(SUBDIR, f'{ses}/fmap')):
            if 'dir-AP' in file and f'run-{i+1}' in file and file.endswith('.json'):
                epi = file

        if epi:
            with open(os.path.join(SUBDIR, f'{ses}/fmap', epi), 'r') as json_file:
                fmap_data = json.load(json_file)
                shim = fmap_data['ShimSetting']
                time_fmap_pre = fmap_data['AcquisitionTime']

            for func_file in os.listdir(os.path.join(SUBDIR, f'{ses}/func')):
                if func_file.endswith('_bold.nii.gz') and func_file.endswith('.json'):
                    with open(os.path.join(SUBDIR, f'{ses}/func', func_file), 'r') as func_json_file:
                        func_data = json.load(func_json_file)
                        shimX = func_data['ShimSetting']
                        time_func = func_data['AcquisitionTime']
                        funci = func_file.replace(SUBDIR, '')

                        if time_fmap_pre < time_func and shim == shimX:
                            intended_for = [funci]

                            fmap_data.pop('IntendedFor', None)
                            fmap_data['IntendedFor'] = intended_for
                            with open(os.path.join(SUBDIR, f'{ses}/fmap', epi), 'w') as updated_json_file:
                                json.dump(fmap_data, updated_json_file, indent=4)

                            func_data.pop('B0FieldSource', None)
                            with open(os.path.join(SUBDIR, f'{ses}/func', func_file), 'w') as updated_func_json_file:
                                json.dump(func_data, updated_func_json_file, indent=4)
