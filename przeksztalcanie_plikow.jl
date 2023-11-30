

#segment odpowiadający za zmianę formatu plików

using WAV
using FFMPEG



files = readdir("music", join=true) |> x -> filter(x -> endswith(x, ".mp3"), x)

for (i, mp3_file_path) in enumerate(files)
    wav_file_path = replace(mp3_file_path, ".mp3" => ".wav")  # Tworzy ścieżkę dla pliku .wav
    run(`ffmpeg -i $mp3_file_path $wav_file_path`)
end


#segment odpowiadajacy za ciecie plikow

function cut_the_files(audio_file::String, cut_length::Float64, output_folder::String)
    wav_audio, sample_rate = WAV.wavread(audio_file)

    file_name = split(audio_file, '/')[end]
    file_name_without_extension = split(file_name, '.')[1]
    segment_samples = Int(sample_rate * cut_length)
    numeration = div(length(wav_audio), segment_samples)
    for i in 1:numeration
        start_index = (i - 1) * segment_samples + 1
        end_index = i * segment_samples
        if end_index > length(wav_audio)
            end_index = length(wav_audio)
            break
        else

            segment_data = wav_audio[start_index:end_index, :]
            output_file = joinpath(output_folder, "$(file_name_without_extension)_$i.wav")
            WAV.wavwrite(segment_data, output_file, Fs=sample_rate)
    
     
        end
    end    
end

input_file="music/rap/50cent.wav"
output_folder = "music/cut_rap"
segment_duration = 120.0

cut_the_files(input_file, Float64(segment_duration), output_folder)
