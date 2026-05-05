# Comparison-of-Motor-Imagery-to-Motor-execution-in-terms-of-EEG-connectivity

## Overview
This project investigates differences in EEG functional connectivity between **motor execution (ME)** and **motor imagery (MI)**, compared to **resting state**.

The analysis focuses on connectivity patterns in:
- **Sensorimotor regions**
- **Fronto-parietal regions**

Connectivity is evaluated in two frequency bands:
- **Alpha (8–13 Hz)**
- **Beta (13–30 Hz)**

The goal is to understand how brain network organization changes across conditions and how it differs between left- and right-hand tasks.

---

## Repository Structure
```
├── eeg_connectivity_analysis.m % Core connectivity computation
├── plot_connectivity_metrics.m % Visualization of results
├── EEG_report.pdf % Full project report
```

---

## Methods

### Preprocessing
EEG preprocessing was performed externally using **EEGLAB**, including:
- Band-pass filtering (2–30 Hz)
- Notch filter at 50 Hz
- Downsampling to 250 Hz
- Channel cleaning and interpolation
- Re-referencing to average
- ICA-based artifact removal

The cleaned dataset was segmented into:
- Rest
- Motor Execution (Left / Right)
- Motor Imagery (Left / Right)

---

### Connectivity Analysis

Connectivity is computed using **magnitude-squared coherence**:

- MATLAB function: `mscohere`
- Computed for each pair of EEG channels
- Averaged within frequency bands:
  - Alpha (8–13 Hz)
  - Beta (13–30 Hz)

Two main metrics are extracted:

#### Mean Coherence
Average connectivity strength across all channel pairs.

#### Network Density
Proportion of connections above a fixed threshold (0.4).

---

### Regions of Interest

Analysis is performed on:
- All electrodes
- Sensorimotor electrodes
- Fronto-parietal electrodes
- Ipsilateral vs contralateral hemispheres

---

## Scripts Description

### `eeg_connectivity_analysis.m`
This is the **main analysis script**. It:

- Loads preprocessed EEG data
- Computes coherence between all channel pairs
- Builds the connectivity matrix
- Applies thresholding to extract significant connections
- Computes:
  - Mean coherence
  - Network density
- Extracts subsets (sensorimotor, fronto-parietal)
- Generates:
  - Connectivity matrices
  - Brain network graphs
  - Degree distributions

---

### `plot_connectivity_metrics.m`
This script is used for **final visualization and comparison**.

It:
- Plots mean coherence across conditions:
  - Rest, ME, MI
- Compares:
  - Left vs right hand
  - Ipsilateral vs contralateral activity
- Plots network density
- Separates results for:
  - Alpha band
  - Beta band

---

## How to Run

1. Open MATLAB

2. Run the connectivity analysis:
   ```matlab
   eeg_connectivity_analysis

3. Then generate the plots:
   ```matlab
   plot_connectivity_metrics

Make sure:
- EEGLAB is installed and added to your MATLAB path
- The '.set' EEG dataset is available in your working directory

---

## Results Summary

### Alpha Band
- Higher sensorimotor coherence at rest
- Increased fronto-parietal connectivity during tasks

### Beta Band
- Stronger fronto-parietal connectivity at rest
- Decrease during motor execution (release of control)

### Lateralization
- Stronger connectivity in the left hemisphere (right-handed subject)

---

## Limitations
- Single-subject dataset
- Noise in EEG acquisition
- No correction for volume conduction

---

## References

See full discussion and references in:
```
EEG_report.pdf
```

