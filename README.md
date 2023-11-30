# WNO

The project is being carried out during the 5th semester of studies in Automation, Cybernetics, and Robotics by Tobiasz Mańkowski.

The program comprises two subprograms:

**Audio Classification Utility**
Description
This Julia-based utility enables audio classification tasks by employing Fast Fourier Transform (FFT) features and Gaussian Naive Bayes classification. It categorizes audio files into different instruments or music genres based on their spectral characteristics.

File Processing Functions
1. process_audio(audio_file): Reads a WAV audio file and calculates its FFT (Fast Fourier Transform), returning the FFT results.
2. complex_to_real_fft(fft_result): Converts complex FFT results into real values for further processing.

Utility Functions

1. chose_utility(wybor, users_choice, nazwa_pliku): A function that directs the workflow based on the chosen mode:
 - Mode 1 (Instruments): Classifies audio files into violin, guitar, or piano categories.
 - Mode 2 (Music Genres): Categorizes audio files into rap, rock, country, disco,  - classical, or jazz genres.
 - Mode 3 (File Analysis): Allows for the analysis of a specific audio file.
 - Mode 4 (Future Expansion): Placeholder for potential future functionality.

Usage

1. Modes of Operation:
Run the script and select a mode by entering the corresponding number:
1: Instrument classification
2: Music genre classification
3: Analysis of a specific audio file
4: Placeholder for future functionalities
2. Mode 1 (Instruments):
 - Classifies audio files into violin, guitar, or piano categories.
 - Requires specific folders named music/violin, music/guitar, and music/piano.
3. Mode 2 (Music Genres):
 - Categorizes audio files into rap, rock, country, disco, classical, or jazz genres.
 - Requires folders named music/cut_classical2, music/cut_rap2, music/cut_rock2, music/cut_disco2, music/cut_jazz2, and music/cut_country2.
4. Mode 3 (File Analysis):
 - Enables analysis of a particular audio file specified during runtime.
 - Follow the prompts to select the file for analysis.
Additional Notes:
Ensure WAV audio files are available in the specified directories for accurate classification.
The utility leverages FFT features and Gaussian Naive Bayes classification for audio categorization.

**Audio File Format Conversion and Cutting Utility**
Description
This program is designed to assist in the conversion of audio files from MP3 to WAV format and subsequently cutting these files into smaller segments. The utility employs the Julia programming language and relies on the WAV and FFMPEG libraries for file manipulation and format conversion.

File Format Conversion
The utility begins by scanning the specified directory (music directory in this case) for MP3 files. For each MP3 file found, the program uses FFMPEG to convert it into the WAV format.
It achieves this conversion by executing the following steps:

1. Locates all MP3 files within the designated directory.
2. Utilizes FFMPEG to convert each MP3 file to its corresponding WAV format.
3. Saves the converted WAV files in the same directory as the original MP3 files.
4. File Cutting


 The utility also includes a function named cut_the_files that allows for the segmentation of WAV audio files into smaller segments of a specified duration. This function works as follows:

1. Reads the WAV audio file and extracts its data along with the sample rate using the WAV library.
2. Divides the audio file into segments based on the specified duration.
3. Iterates through these segments and creates new audio files, each containing a segment of the original audio.
4. The output files are saved in the designated output folder, appending a numerical identifier to their names to indicate the order of segments.
The output files are saved in the designated output folder, appending a numerical identifier to their names to indicate the order of segments.
