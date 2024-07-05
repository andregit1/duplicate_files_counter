# Duplicate Files Counter

This Ruby application scans a specified directory to count and identify files with the same content. It efficiently handles large files and directories by comparing file contents using SHA-256 hashes.

## How to Run the Application

### 1. Clone the Repository

```sh
git clone https://github.com/andregit1/duplicate_files_counter.git
```

### 2. Navigate to the Directory

```sh
cd duplicate_files_counter
```

### 3. Run the Script

Use the command line to run the script:

```sh
ruby duplicate_file_counter.rb /path/to/directory
```

Replace `/path/to/directory` with the path of the directory you want to scan.

## Explanation

### 1. `calculate_file_hash`

- **Purpose:** Computes a SHA-256 hash of a file’s content.
- **Function:** Reads the file in chunks to handle large files efficiently.

### 2. `find_duplicate_files`

- **Purpose:** Traverses the given directory recursively to find duplicate files.
- **Function:** Uses `Find.find` to traverse the directory and calculates the hash for each file, storing the count of each hash in a hash map.

### 3. `display_largest_group`

- **Purpose:** Finds the file content hash with the highest count.
- **Function:** Prints the hash and the number of files that share this hash.

### 4. Dynamic Directory Input

- **Purpose:** Makes the script flexible and reusable.
- **Function:** Takes the directory path as a command-line argument, allowing it to scan any directory without changing the code.

### 5. Real-time Loading Info

- **Purpose:** Provides feedback on the scanning progress.
- **Function:** Tracks and prints the progress of file scanning using `total_files` and `processed_files`.

### 6. Saving Results to File

- **Purpose:** Saves detailed scan results for later reference.
- **Function:**
  - Stores file paths for each hash in `file_hash_details`.
  - Writes detailed results to a `.txt` file with a timestamp.
  - Informs the user when the results are saved.

## Example Output

After running the script, a file named `duplicate_files_report_<timestamp>.txt` will be created in the current directory, containing:

- A list of file hashes and their counts.
- The file paths of the duplicated files.
