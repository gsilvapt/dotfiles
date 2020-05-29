# dirseaarch
dirsearch(){ runs dirsearch and takes host and extension as arguments
    python3 ~/tools/dirsearch/dirsearch.py -u $1 -e $2 -t 50 -b
}

# sqlmap
sqlmap(){
    python ~/tools/sqlmap*/sqlmap.py -u $1
}

