#!/bin/bash
### Shoot a fixed number of photos in a loop
#
# If camera is mounted we need to unmount it
mkdir -p originals
mkdir -p montages

export CAMERA_MOUNT_POINTS=`gvfs-mount -l | grep gphoto2 | sed 's/.*\(gphoto2.*\)$/\1/' | uniq`
for CAMERA_MOUNT_POINT in $CAMERA_MOUNT_POINTS
do
    echo Unmounting mounted camera from $CAMERA_MOUNT_POINT.
    gvfs-mount -u $CAMERA_MOUNT_POINT &
done

echo "Shooting 4 photos. SMILE."
sleep 3
echo "Shooting now."

for i in {1..4}
  do
  gphoto2 --capture-image-and-download --keep --filename "%y-%m-%d-%H-%M-%S.JPG"
  echo "************* $i *************"
  sleep 1
  done

MONTAGE=montages/montage_`date -u +"%Y-%m-%dT%H:%M:%SZ"`.jpg
echo "Creating montage $MONTAGE"

# Create 20px margins on a 2x2 grid
montage -mode concatenate -geometry +20+20 -tile 2x *.JPG $MONTAGE

echo "Backing up originals"
mv *.JPG originals/

echo "Done :)"
