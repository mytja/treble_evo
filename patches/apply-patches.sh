#!/bin/bash

# TrebleDroid patches are TrebleDroid's patches_for_developers.zip
# TrebleDroid personal patches are TrebleDroid's patches, except that they apply on top of other patches on EvolutionX's source
# Personal patches are my own patches, mostly to ensure EvolutionX compatibility

set -e

source="$(readlink -f -- $1)"
trebledroid="$source/patches/trebledroid"
trebledroid_personal="$source/patches/trebledroid_personal"
personal="$source/patches/personal"

printf "\n ### APPLYING TREBLEDROID PATCHES ###\n";
sleep 1.0;
for path in $(cd $trebledroid; echo *); do
	tree="$(tr _ / <<<$path | sed -e 's;platform/;;g')"
	printf "\n| $path $tree ###\n";
	[ "$tree" == build ] && tree=build/make
    [ "$tree" == vendor/hardware/overlay ] && tree=vendor/hardware_overlay
    [ "$tree" == treble/app ] && tree=treble_app
	pushd $tree

	for patch in $trebledroid/$path/*.patch; do
		# Check if patch is already applied
		if patch -f -p1 --dry-run -R < $patch > /dev/null; then
            printf "### ALREDY APPLIED: $patch \n";
			continue
		fi

		if git apply --check $patch; then
			git am $patch
		elif patch -f -p1 --dry-run < $patch > /dev/null; then
			#This will fail
			git am $patch || true
			patch -f -p1 < $patch
			git add -u
			git am --continue
		else
			printf "### FAILED APPLYING: $patch \n"
		fi
	done

	popd
done

printf "\n ### APPLYING TREBLEDROID (PERSONAL) PATCHES ###\n";
sleep 1.0;
for path in $(cd $trebledroid_personal; echo *); do
        tree="$(tr _ / <<<$path | sed -e 's;platform/;;g')"
        printf "\n| $path $tree ###\n";
        [ "$tree" == build ] && tree=build/make
    [ "$tree" == vendor/hardware/overlay ] && tree=vendor/hardware_overlay
    [ "$tree" == treble/app ] && tree=treble_app
        pushd $tree

        for patch in $trebledroid_personal/$path/*.patch; do
                # Check if patch is already applied
                if patch -f -p1 --dry-run -R < $patch > /dev/null; then
            printf "### ALREDY APPLIED: $patch \n";
                        continue
                fi

                if git apply --check $patch; then
                        git am $patch
                elif patch -f -p1 --dry-run < $patch > /dev/null; then
                        #This will fail
                        git am $patch || true
                        patch -f -p1 < $patch
                        git add -u
                        git am --continue
                else
                        printf "### FAILED APPLYING: $patch \n"
                fi
        done

        popd
done

printf "\n### APPLYING PERSONAL PATCHES ###\n";
sleep 1.0;
for path_personal in $(cd $personal; echo *); do
	tree="$(tr _ / <<<$path_personal | sed -e 's;platform/;;g')"
	printf "\n| $path_personal ###\n";
	[ "$tree" == build ] && tree=build/make
    [ "$tree" == vendor/hardware/overlay ] && tree=vendor/hardware_overlay
    [ "$tree" == treble/app ] && tree=treble_app
	pushd $tree

	for patch in $personal/$path_personal/*.patch; do
		# Check if patch is already applied
		if patch -f -p1 --dry-run -R < $patch > /dev/null; then
            printf "### ALREDY APPLIED: $patch \n";
			continue
		fi

		if git apply --check $patch; then
			git am $patch
		elif patch -f -p1 --dry-run < $patch > /dev/null; then
			#This will fail
			git am $patch || true
			patch -f -p1 < $patch
			git add -u
			git am --continue
		else
			printf "### FAILED APPLYING: $patch \n"
		fi
	done

	popd
done
