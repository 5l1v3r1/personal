# Find

### Find files
  
    find -type f   

### Find paths                                                                                 
  
    find -type d

### Find symlinks                                                                                     
  
    find -type l   

### Search 3 levels deep                                                                               
  
    find -depth 2         

### Search regex                                                                            
  
    find -regex PATTERN     

### Exactly 8 512-bit blocks                                                              
  
    find -size 8    

###  ### Smaller than 128 bytes                                                                                  
  
    find -size -128c

### Exactly 1440KiB                                                                                 
  
    find -size 1440k

### Larger than 10MiB                                                                                  
  
    find -size +10M            

### Find files larger than 2GiB 
  
    find -size +2G                

### Find files larger them 500MB
  
    find / -type f -size +500M                                                                        

### Find executable files

    for i in `find -type f`; do [ -x $i ] && echo "$i is executable"; done

### Search for STRING in all folders
  
    find . -type f | parallel -k -j150% -n 1000 -m grep -H -n STRING {}

###  Find broken symlinks and delete them 
  
    find -L /path/to/check -type l -delete   

###  Find all the links to a file
  
    find -L / -samefile /path/to/file -exec ls -ld {} +

###  Find the most recently changed files (recursively)
  
    find . -type f -printf '%TY-%Tm-%Td %TT %p\n' | sort

### Remove fucked dirnames

    ls -li|find . -inum 4063242 -delete

### Find all gz files and extract them
  
    find . -type f -iname "*.gz" -print0 -execdir atool -x {} \; -delete

### Last accessed between now and 24 hours ago
  
    find -atime 0                                   

### Accessed more than 24 hours ago                                                  
  
    find -atime +0 

### Accessed between 24 and 48 hours ago                                                                                
  
    find -atime 1         

###  Accessed more than 48 hours ago                                                                            
  
    find -atime +1 

### Accessed less than 24 hours ago (same a 0)                                                                                
  
    find -atime -1       

### File status changed within the last 6 hours and 30 minutes                                                                            
  
    find -ctime -6h30m     

### Files modified within the last day                                                    
  
    find /etc -type f -ctime -1      

### Last modified more than 1 week ago                                                                
  
    find -mtime +1w                                                                              

### Hs exactly these permissions", i.e. bitwise equality. 
  
    find /path -perm 777                                                                              

### Change folders permissiosn top 775
  
    find . -type d -exec chmod 775 {} \;       

### Change files permissiosn top 664                                                       
  
    find . -type f -exec chmod 775 {} \;                                                           

### Find deleleted fles andrestore
  
    find /proc/*/fd -ls | grep  '(deleted)' 

### Find all 0 byted size files
  
    find "$dir" -size 0       

### Find file typ, for example compress for ccompresed filesx
  
    find / -type f -exec file {} +                                                                    

### Exclude  multiple directories - Various Methos
  
    find . -type d \( -path dir1 -o -path dir2 -o -path dir3 \) -prune -false -o -name '*.txt'        
  
    find -name "*.js" -not -path "./directory/*"
  
    find / -name MyFile ! -path '*/Directory/*'
  
    find . -name '*.js' | grep -v excludeddir
  
    find . -name '*.js' -and -not -path directory
  
    find /glftpd/site/ -type d -not -path "*/glftpd/site/databases/*" 
