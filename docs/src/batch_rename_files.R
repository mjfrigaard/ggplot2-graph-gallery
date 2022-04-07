#=====================================================================#
# file: batch_rename_files.R
# Authored by and feedback to mjfrigaard@gmail.com
# MIT License
# Version: 0.1
#=====================================================================#
#
batch_rename_files <- function(path, pattern, replace, prefix, extension) {
    
    # get file_ext
    file_ext <- paste0("[.]", extension, "$")
    
    # get dir_files
    dir_files <- fs::dir_info(path = path, regexp = file_ext) 
    dir_files <- dplyr::filter(dir_files, type == "file") 
    dir_files <- dplyr::select(dir_files, path, type, ends_with("time"))
    
    # define pattern
    regex_pattern <- as.character(pattern)
    # define replace
    regex_replace <- as.character(replace)
    
        # prefix
    if (prefix == TRUE) {
        
        regex <- paste0("^", regex_pattern)
         # pattern
    } else { 
        
        regex <- as.character(regex_pattern)
       
    } 

    file_names <- mutate(dir_files, file_name = basename(path))
    
    new_file_names <- mutate(file_names, 
           new_file_name = 
                    stringr::str_replace_all(file_name,
                    pattern = regex, 
                    replacement = regex_replace))
    
    new_paths <- mutate(new_file_names, 
                    base_path = 
                    stringr::str_remove_all(string = path, pattern = file_name),
                    new_path = paste0(base_path, new_file_name)) %>% 
    select(path, new_path, file_name, new_file_name, ends_with("time"))
    
    old_file_paths <- new_paths$path
    new_file_paths <- new_paths$new_path
    
    # return(new_file_paths)
    
    purrr::quietly(purrr::map2(.x = old_file_paths, .y = new_file_paths,
                               file.rename))
    
}