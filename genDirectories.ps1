# Define the base directory where the new directories will be created
$baseDir = "C:\RandomDirectory"

# Define the maximum number of subdirectories to create for each directory
$maxSubDirs = 5

# Define the maximum number of levels of subdirectories
$maxLevels = 3

# Create the base directory if it doesn't already exist
if (!(Test-Path $baseDir)) {
  New-Item -ItemType Directory -Path $baseDir
}

# Function to create a random number of subdirectories for a given directory
function Create-RandomSubDirs($dir, $level) {
  # Generate a random number of subdirectories to create
  $numSubDirs = Get-Random -Minimum 1 -Maximum $maxSubDirs

  # Create the specified number of subdirectories
  for ($i = 0; $i -lt $numSubDirs; $i++) {
    # Generate a random name for the subdirectory
    $subDirName = -join ((65..90) + (97..122) | Get-Random -Count 8 | % {[char]$_})

    # Create the subdirectory
    $subDirPath = Join-Path $dir $subDirName
    New-Item -ItemType Directory -Path $subDirPath

    # If the maximum level of subdirectories hasn't been reached, recursively create subdirectories for the current subdirectory
    if ($level -lt $maxLevels) {
      Create-RandomSubDirs $subDirPath ($level + 1)
    }
  }
}

# Create random subdirectories in the base directory
Create-RandomSubDirs $baseDir 1
