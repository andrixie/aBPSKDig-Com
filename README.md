# BPSKDigCom

A comprehensive BPSK digital communication system simulator built in MATLAB. Demonstrates the complete signal processing pipeline from modulation and transmission through demodulation, matched filtering, and spectral analysis.

## Features

- **BPSK Modulation & Demodulation**: Complete implementation of Binary Phase-Shift Keying with coherent detection
- **Matched Filtering**: Optimal signal detection using matched filter correlation
- **Pulse Shaping**: Rectangular pulse shaping with proper upsampling
- **Spectral Analysis**: FFT-based Power Spectral Density (PSD) estimation with theoretical validation
- **Bartlett Method**: Variance reduction through averaging multiple PSD estimates
- **Signal Visualization**: Comprehensive plots for signal analysis and validation
- **Perfect Detection**: Zero symbol error rate over ideal channels

## System Architecture

```
Data Source → Symbol Mapper → Transmit Filter → Modulator
                                                      ↓
Data Sink ← Detector ← Matched Filter ← Demodulator
```

### Key Components

| Component | Function |
|-----------|----------|
| **Symbol Mapper** | Converts binary data to antipodal signals (BPSK: 0→-1, 1→+1) |
| **Transmit Filter** | Pulse shaping with rectangular filter and upsampling |
| **Modulator** | Modulates baseband signal to bandpass using carrier frequency |
| **Demodulator** | Coherent demodulation to recover baseband signal |
| **Matched Filter** | Optimal filtering for symbol detection |
| **Detector** | Threshold decision-making for symbol recovery |

## System Parameters

| Parameter | Description |
|-----------|-------------|
| Message Length | Number of information bits |
| Upsampling Factor | Samples per symbol |
| Symbol Period | Duration of one symbol |
| Carrier Frequency | Modulation carrier |
| Total Samples | Total simulation samples |

## Installation

### Requirements
- MATLAB R2020a or later
- Signal Processing Toolbox (optional)

### Setup

1. Clone the repository:
```bash
git clone https://github.com/yourusername/BPSKDigCom.git
cd BPSKDigCom
```

2. Open MATLAB and navigate to the project directory

## Usage

Run the main simulation script:
```matlab
BPSKSim
```

This will execute the complete BPSK communication system and generate:
- Symbol detection results with error count
- Transmitted and received signal plots
- PSD estimates (FFT and Bartlett methods)
- Comparison with theoretical PSD

## Project Structure

```
BPSKDigCom/
├── src/
│   ├── BPSKSim.m                 # Main simulation script
│   ├── InitializeParameters.m     # System parameter setup
│   ├── SymbolMapper.m             # BPSK symbol mapping
│   ├── TransmitFilter.m           # Pulse shaping filter
│   ├── EstimatePSD.m              # FFT-based PSD estimation
│   ├── Modulate.m                 # Bandpass modulation
│   ├── Demodulate.m               # Coherent demodulation
│   ├── BasebandDetection.m        # Matched filtering and detection
│   ├── BartlettPSD.m              # Bartlett method PSD averaging
│   └── PlotResults.m              # Visualization utilities
├── figures/
│   └── block_diagram.png          # System block diagram
├── results/
│   └── (Generated simulation outputs)
├── report/
│   └── BPSK_Report.pdf            # Detailed technical report
└── README.md
```

## Results

### Detection Performance
- **Symbol Error Rate**: 0% (ideal channel)
- **Detection Errors**: 0/128 symbols
- All transmitted symbols correctly recovered over ideal channel

### Spectral Characteristics
- Main lobe centered at 0 Hz (baseband)
- Main lobe width: ≈ ±50 Hz
- Side lobes decay as 1/f²
- Excellent agreement between empirical and theoretical PSD

## Key Outputs

The simulator generates five analysis plots:
1. **Received baseband signal** - After matched filter detection
2. **Transmitted bandpass signal** - Modulated signal over carrier
3. **Received baseband signal** - After coherent demodulation
4. **PSD Comparison** - Estimated vs. theoretical power spectral density
5. **Bartlett PSD** - Smoothed estimate vs. theoretical PSD

## Mathematical Foundations

### BPSK Mapping
$$s_i = 2a_i - 1, \quad s_i \in \{-1, +1\}$$

### Transmitted Signal
$$v_c(t) = \tilde{v}(t) \cos(2\pi f_c t)$$

### Matched Filter Output
$$y[n] = (r_{\tilde{v}} * h_T)[n] \cdot T_s$$

### Theoretical PSD
$$\text{PSD}_{\text{theory}}(f) = \frac{1}{T} \left| T \cdot \text{sinc}(fT) \right|^2$$

## Future Enhancements

- [ ] AWGN channel with configurable SNR
- [ ] Fading channel models
- [ ] Alternative pulse shapes (raised cosine, Gaussian)
- [ ] Higher-order modulation (QPSK, QAM)
- [ ] Adaptive equalization techniques
- [ ] Symbol error rate vs. SNR curves

## References

- Proakis, J. G., & Salehi, M. (2007). *Digital Communications*. McGraw-Hill.
- Haykin, S. (2001). *Communication Systems*. John Wiley & Sons.
- Sklar, B. (2001). *Digital Communications: Fundamentals and Applications*. Prentice Hall.

## License

This project is open source and available under the [MIT License](LICENSE).

## Author

Andrea Taguinod

---

For detailed technical analysis, see the [BPSK_Report.pdf](report/BPSK_Report.pdf) in the report folder.
