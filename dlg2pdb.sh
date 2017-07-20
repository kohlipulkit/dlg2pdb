read -p "Enter location of dlg file: " location
grep '^DOCKED' $location | cut -c9- > my_docking.pdbqt
cut -c-66 my_docking.pdbqt > dock.pdb
a=$(grep ENDMDL dock.pdb | wc -l)
b=$((a - 2))
csplit -k -s -n 3 -f dock. dock.pdb '/^ENDMDL/+1' '{'$b'}'
read -p "Enter location of macromolecule: " receptor
for f in dock.[0-9][0-9][0-9]
do
  mv $f $f.pdb
  cat $receptor $f.pdb | grep -v '^END   ' | grep -v '^END$' > complex$f.pdb
done
