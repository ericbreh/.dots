# Photo Backup Workflow

> [!CAUTION]
> Check mount point!

## Add photos to `photos-unsorted`

```sh
rsync -a --partial --info=progress2,stats2 /path/to/source/ /path/to/destination/
```

#### Google Photos/Drive

Download with Google Takeout, then use `GooglePhotosTakeoutHelper` to fix metadata.

Fix `date-unknown` files by trying to read filename

```sh
cd ALL_PHOTOS/date-unknown
exiftool "-AllDates<Filename" -overwrite_original .
```

## Deduplicate with `czkawka`

* Add both `/media/ericbreh/BUFFALO/photos-unsorted` and `/media/ericbreh/BUFFALO/photos` to the directories list.

## Organize with `exiftool`

```sh
exiftool -r -d /media/ericbreh/BUFFALO/photos/%Y/%m \
'-Directory<DateTimeOriginal' \
'-Directory<CreateDate' \
'-Directory<FileModifyDate' \
/media/ericbreh/BUFFALO/photos-unsorted
```

#### Cleanup

```sh
find . -type f \( -iname "*.aae" -o -iname "*.plist" -o -iname "*.db" -o -iname "*.apdb" \) -delete
find . -depth -type d -empty -delete
```

#### Sync Drives

```sh
rsync -a --partial --info=progress2,stats2 --exclude="lost+found" --delete -n /media/ericbreh/BUFFALO/ /media/ericbreh/SEAGATE/
```
