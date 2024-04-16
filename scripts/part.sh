read -p "formatting disk $1 with hostname $2 is this correct? " IN
read -p "is the disk an nvme drive? " NVME
if [ "$IN" == "y" ]; then
	echo "commencing"
	#format disk
	parted $1 mklabel gpt mkpart primary fat32 1MiB 512MiB mkpart primary linux-swap 512MiB 31029MiB mkpart primary btrfs 31029MiB 40% mkpart primary btrfs 40% 100%
	if [ "$NVME" == "y" ]; then
		e2label $1p1 BOOT
		e2label $1p2 SWAP
		e2label $1p3 ROOT
		e2label $1p4 HOME
	else
		e2label "$1"1 BOOT
		e2label "$1"2 SWAP
		e2label "$1"3 ROOT
		e2label "$1"4 HOME
	fi
	# install nixos
	nixos-install --flake ./nix/.#$2
else
	echo "aborting"
fi
