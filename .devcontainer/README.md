# VS Code Settings for Docker


This folder contains settings for VS Code to run in the build container.
This approach allows having full-blown auto-completion, formatting based on clang-tidy, and the rest of the cool features provided by `clangd`
and [vscode-choreclangd](https://marketplace.visualstudio.com/items?itemName=llvm-vs-code-extensions.vscode-clangd).

How to make it work:
1. Download the latest [VS Code](https://code.visualstudio.com/download)
1. Launch it from the terminal:
    ```sh
    cd MyProject
    code .
    ```
1. Install extensions recommended by the workplace (Remote Containers, vscode-clangd)
1. Once installed, VS Code will propose to open the project in the container, agree
1. If VS Code asks to install `clangd`, agree as well

After the installation is good to go, `clangd` starts indexing source files, and the result is stored in the directory `.cache`.
