# Enclave Builder GitHub Action

This GitHub Action automates the process of building and deploying enclaves using [AWS Nitro Enclaves](https://aws.amazon.com/ec2/nitro/) with Docker. It’s designed to streamline enclave creation, leveraging Docker multi-platform builds and GitHub Actions. This project includes support for large file storage using Git LFS, ideal for managing large `.eif` (enclave image file) binaries.

## Tech Stack

- **GitHub Actions**: Automates the build and deployment processes
- **AWS Nitro Enclaves**: Provides isolated compute environments for high-security workloads
- **Docker**: Manages containerization for flexible, multi-platform builds
- **Git Large File Storage (LFS)**: Handles large file versioning, crucial for managing large `.eif` binaries

---

## Requirements

1. **Docker Hub Account**: This action requires access to Docker Hub for image creation. Ensure you have a Docker Hub account with credentials stored in your GitHub Secrets.
2. **AWS Nitro Enclaves Enabled Environment**: AWS Nitro Enclaves must be enabled to run and test enclaves.
3. **Git LFS**: This repository uses Git LFS to manage large `.eif` files, which exceed GitHub’s regular file size limits.

### GitHub Secrets

Add the following secrets to your repository’s settings to securely provide credentials for Docker and GitHub LFS:

- `DOCKER_USERNAME`: Docker Hub username
- `DOCKER_PASSWORD`: Docker Hub password
- `GITHUB_TOKEN`: GitHub token for committing files in GitHub Actions

## Usage

### Steps to Set Up and Run the Action

1. **Fork or Clone the Repository**: Fork this repository or clone it locally.

   ```bash
   git clone https://github.com/your-username/enclave-builder-action.git

   ```

2. **Set Up Git LFS**: Ensure Git LFS is installed on your local environment and track `.eif` files.

   ```bash
   git lfs install
   git lfs track "*.eif"
   git add .gitattributes
   git commit -m "Track .eif files using Git LFS"
   ```

3: **Configure Secrets**

    Go to **Settings > Secrets** in your GitHub repository and add the following secrets:

    - `DOCKER_USERNAME`
    - `DOCKER_PASSWORD`
    - `GITHUB_TOKEN`

4: **Push to GitHub**

Once configured, push changes to GitHub to trigger the action.

```bash
    git add .
    git commit -m "Initial setup"
    git push origin master
```

5: **Check Workflow Execution**

After pushing the changes, the GitHub Actions workflow will start automatically. You can monitor the progress in the **Actions** tab in your GitHub repository.

6: **Verify Output**

After successful execution, the generated `enclave.eif` file will be pushed back to your repository if configured correctly. Check under the specified directory in your repository.

## Workflow Overview

The workflow (`.github/workflows/build-enclave.yml`) performs the following steps:

1. **Checkout Repository:** Clones the repository to the GitHub Actions runner.
2. **Log in to Docker Hub:** Authenticates Docker using the provided secrets.
3. **File Verification:** Checks if required files (`Dockerfile`, `setup.sh`, and `supervisord.conf`) are present.
4. **Directory Setup:** Ensures the necessary directory structure for Docker build.
5. **Docker Image Build:** Builds a Docker image that supports the multi-platform build environment for the enclave.
6. **Build Enclave:** Uses `nitro-cli` to build the enclave image and save it as `enclave.eif`.
7. **File Location Check:** Searches for the `enclave.eif` file and ensures it's accessible.
8. **Git LFS Commit and Push:** Uses Git LFS to commit and push the large `.eif` file to the repository.

### Notes

- Ensure that you have the necessary permissions to push changes to the repository.
- The `enclave.eif` file may be large, exceeding GitHub's file size limits. Consider using Git Large File Storage (LFS) if you encounter issues pushing large files.
- You may want to modify the GitHub Actions workflow as per your project's specific requirements.
- Review the logs in the **Actions** tab to debug any issues during the workflow execution.

## Viewing PCR Values of Your Enclaves

The PCR values of your Enclaves are available in the action section after the Build enclave step has completed successfully.

### Steps to View PCR Values

1. Navigate to the **Actions** tab in your repository.
2. Ensure the **Build enclave** step has completed successfully.
3. Scroll down to the **Build enclave** step and expand it.
4. You can now view the PCR0, PCR1, and PCR2 values of your Enclaves.
