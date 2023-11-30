

using WAV
using FFTW
using LinearAlgebra: real
using ScikitLearn: fit!, predict
using ScikitLearn: @sk_import
@sk_import naive_bayes: GaussianNB


function process_audio(audio_file)
    # Wczytanie pliku dźwiękowego w formacie WAV
    wav_audio, sample_rate = WAV.wavread(audio_file)
    function calculate_fft(audio_data)
        
        #czas maksymalny pliku
        Pt_sek= 5292000
        duration = min(Pt_sek, size(audio_data, 1))   
        audio_segment = audio_data[1:duration, 1]   

        fft_result = fft(audio_segment)
        # println(size(fft_result))
        println("file $audio_file loaded")
        return fft_result
    end
    return calculate_fft(wav_audio)
end

# Przekształcenie wyników FFT na wartości rzeczywiste
function complex_to_real_fft(fft_result)
    return real(fft_result)
end


function chose_utility(wybor, users_choice, nazwa_pliku)
    
    if wybor==1
        folder_path_violin = "music/violin"
        folder_path_guitar = "music/guitar"
        folder_path_piano = "music/piano"
        if users_choice==true
            folder_path_test = "music"
        else
            folder_path_test = "music/test"
        end
        guitar_files = filter(x -> endswith(x, ".wav"), readdir(folder_path_guitar))
        piano_files = filter(x -> endswith(x, ".wav"), readdir(folder_path_piano))
        violin_files = filter(x -> endswith(x, ".wav"), readdir(folder_path_violin))
        if users_choice==true
            test_files = nazwa_pliku
        else
            test_files = filter(x -> endswith(x, ".wav"), readdir(folder_path_test))
        end
       
        
        #tworzenie macierzy cech

        feature_matrix_guitar = [complex_to_real_fft(process_audio(joinpath(folder_path_guitar, file))) for file in guitar_files]
        feature_matrix_piano = [complex_to_real_fft(process_audio(joinpath(folder_path_piano, file))) for file in piano_files]
        feature_matrix_violin = [complex_to_real_fft(process_audio(joinpath(folder_path_violin, file))) for file in violin_files]
        if users_choice==true
            feature_matrix_test = [complex_to_real_fft(process_audio(joinpath(folder_path_test, test_files)))]
        else
            feature_matrix_test = [complex_to_real_fft(process_audio(joinpath(folder_path_test, file))) for file in test_files]
        end

        #tworzenie etykiet

        labels_guitar = fill("guitar", length(guitar_files))  
        labels_piano = fill("piano", length(piano_files)) 
        labels_violin = fill("violin", length(violin_files)) 



        #proces trenowania: 

        # Łączenie danych z różnych instrumentów

        all_features = vcat(feature_matrix_guitar, feature_matrix_piano, feature_matrix_violin)
        all_labels = vcat(labels_guitar, labels_piano, labels_violin)

       

    
    elseif wybor==2


        folder_path_classical = "music/cut_classical2"
        folder_path_rap = "music/cut_rap2"
        folder_path_rock = "music/cut_rock2"
        folder_path_disco = "music/cut_disco2"
        folder_path_jazz = "music/cut_jazz2"
        folder_path_country = "music/cut_country2"
        if users_choice==true
            folder_path_test = "music"
        else
            println("\npodaj nazwę folderu do sprawdzenia: ")
            sciezka=readline()
            folder_path_test = "music/$sciezka"
        end

        
        rap_files = filter(x -> endswith(x, ".wav"), readdir(folder_path_rap))
        rock_files = filter(x -> endswith(x, ".wav"), readdir(folder_path_rock))
        country_files = filter(x -> endswith(x, ".wav"), readdir(folder_path_country))
        disco_files = filter(x -> endswith(x, ".wav"), readdir(folder_path_disco))
        jazz_files = filter(x -> endswith(x, ".wav"), readdir(folder_path_jazz))
        classical_files = filter(x -> endswith(x, ".wav"), readdir(folder_path_classical))
        if users_choice==true
            test_files = nazwa_pliku
        else
            test_files = filter(x -> endswith(x, ".wav"), readdir(folder_path_test))
        end
        

        #tworzenie macierzy cech
        feature_matrix_rap = [complex_to_real_fft(process_audio(joinpath(folder_path_rap, file))) for file in rap_files]
        feature_matrix_country = [complex_to_real_fft(process_audio(joinpath(folder_path_country, file))) for file in country_files]
        feature_matrix_rock = [complex_to_real_fft(process_audio(joinpath(folder_path_rock, file))) for file in rock_files]
        feature_matrix_disco = [complex_to_real_fft(process_audio(joinpath(folder_path_disco, file))) for file in disco_files]
	    feature_matrix_classical = [complex_to_real_fft(process_audio(joinpath(folder_path_classical, file))) for file in classical_files]
        feature_matrix_jazz = [complex_to_real_fft(process_audio(joinpath(folder_path_jazz, file))) for file in jazz_files]
        if users_choice==true
            feature_matrix_test = [complex_to_real_fft(process_audio(joinpath(folder_path_test, test_files)))]
        else
            feature_matrix_test = [complex_to_real_fft(process_audio(joinpath(folder_path_test, file))) for file in test_files]
        end
       
        #tworzenie etykiet
        labels_rap = fill("rap", length(rap_files))  
        labels_rock= fill("rock", length(rock_files)) 
        labels_country= fill("country", length(country_files)) 
 	    labels_disco = fill("disco", length(disco_files))  
        labels_classical= fill("classical", length(classical_files)) 
        labels_jazz= fill("jazz", length(jazz_files)) 


        all_features = vcat(feature_matrix_rap, feature_matrix_country, feature_matrix_rock, feature_matrix_disco, feature_matrix_classical, feature_matrix_jazz)
        all_labels = vcat(labels_rap, labels_country, labels_rock, labels_disco, labels_classical, labels_jazz)
    
    elseif wybor==3

        println("podaj nazwe utworu: ")
        sciezka= readline()
        chose_utility(2, true, sciezka)
    
    elseif wybor==4

    else
        println("bledny wybor, sproboj ponownie")    
    end


    

     # tworzenie modelu 
     model = GaussianNB()

     # Trenowanie modelu na przekształconych danych
     fit!(model, all_features, all_labels)

     #TEST

     # Przewidywanie klas dla plików testowych
     test_predictions = predict(model, feature_matrix_test)
     println("Predykcje dla plików testowych:")
     for (i, prediction) in enumerate(test_predictions)
         println("Plik: $(test_files[i]), Predykcja: $prediction")
     end
end
# foldery i pliki


while true
    println("\nwybierz tryb pracy: (1- instrumenty, 2- gatunki muzyczne, 3- analiza wybranego pliku dzwiekowego)")
    warunek= parse(Int, readline())
    chose_utility(warunek, false, "plik")
end