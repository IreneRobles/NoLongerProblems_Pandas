
function Pandas.DataFrame(df::DataFrames.DataFrame)
    temp = "temp.csv"
    #DataFrames.writetable(temp, df) Deprecated in Julia 0.7.0
    CSV.write(temp, df)
    pand_df = Pandas.read_csv(temp)
    rm(temp)
    return pand_df
end


function DataFrames.DataFrame(df::Pandas.DataFrame)
    temp = "temp.csv"
    
    pand_df = Pandas.to_csv(df, temp)
    
    df = CSV.read(temp, DataFrames.DataFrame)
    rm(temp)
    return df
end



function pandas_transform_array_of_array_labels(array_of_arrays::Array, labels::Array; 
        name_array_arrays = :data, name_labels = :label)
    # this function is thought to be able to use seaborn violinplots as I was using them in PyPlot
    array1 = array_of_arrays[1]
    
    for i in 2:length(array_of_arrays)
        array1 = vcat(array1, array_of_arrays[i])
    end
    
    array2 = []
    
    for i in 1:length(array_of_arrays)
        repeated_labels = fill(string(labels[i]), length(array_of_arrays[i]))
        array2 = vcat(array2, repeated_labels)
    end
    
    return Pandas.DataFrame(Dict(name_array_arrays => array1, name_labels => array2))
end