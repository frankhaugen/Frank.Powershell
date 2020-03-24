# .Net Solution 
### Naming
Solutions and projects are customarily named ```Company.Product``` e.g. ```Microsoft.Word```, with the main logic project (classlib) being named the same as the solution, and the rest folowed by ```.Function``` e.g. ```Microsoft.Word.UserInterface```

| Name | Meaning | Type |
| --- | --- | --- |
| Microsoft.Word | Solution and main logic project. This contains all the core functionality of the application, in such a way that it can be dropped into another application and is still functional | classlib |  
| Microsoft.Word.Cli | CommandLineInterface AKA Console or Terminal, is a simple text-UI to allow a user to interact. This should only contain the code needed to work with the core logic and never any logic on it's own, unless it's input validation or mapping | console |
| Microsoft.Word.Api | THis referes to a WebApi that can serve as the backend for a website, or a microsoervice in a microservice architecture | webapi |
| Microsoft.Word.Service | A "worker service" that runs a continous job, (listening for some event maybe). Very similar to CLI | worker |
| Microsoft.Word.Client | Sometimes you want to create some kind of client to "consume" your service, so you make it here. This is distributable as a NuGet-package | classlib |
| Microsoft.Word.Models | All your data-models (classes) goes here, (including enums), to separate these very non-logic classes from any logic | classlib |
| Microsoft.Word.Tests | Here is where your tests go | xunit |

### Structure
```
Root
	Logic
    Communication
    Models
    Tests
```
```
Microsoft.Word
	Microsoft.Word
	Microsoft.Word.Cli
	Microsoft.Word.Models
	Microsoft.Word.Tests
```

### Creating a new .net solution
1. Find create a folder for your solution. e.g. ```C:\repos\Microsoft.Word\``` or rather ````C:\repos\MyName.MyProject```
2. Open CMD/Powershell in this folder, and run the following commands replacing "Microsoft" with your name, and "Word" with you project name:  
```
dotnet new sln
dotnet new gitignore  
echo "# Readme" > readme.md
git init

mkdir Microsoft.Word  
dotnet new classlib -o Microsoft.Word  

mkdir Microsoft.Word.Cli
dotnet new console -o Microsoft.Word.Cli  

mkdir Microsoft.Word.Models
dotnet new classlib -o Microsoft.Word.Models

mkdir Microsoft.Word.Tests
dotnet new xunit -o Microsoft.Word.Tests

dotnet add Microsoft.Word/Microsoft.Word.csproj reference Microsoft.Word.Models/Microsoft.Word.Models.csproj
dotnet add Microsoft.Word.Cli/Microsoft.Word.Cli.csproj reference Microsoft.Word/Microsoft.Word.csproj
dotnet add Microsoft.Word.Tests/Microsoft.Word.Tests.csproj reference Microsoft.Word.Cli/Microsoft.Word.Cli.csproj

dotnet sln Microsoft.Word.sln add Microsoft.Word/Microsoft.Word.csproj
dotnet sln Microsoft.Word.sln add Microsoft.Word.Cli/Microsoft.Word.Cli.csproj
dotnet sln Microsoft.Word.sln add Microsoft.Word.Models/Microsoft.Word.Models.csproj
dotnet sln Microsoft.Word.sln add Microsoft.Word.Tests/Microsoft.Word.Tests.csproj

dotnet restore
dotnet build
dotnet test

git add *
git commit -m "Initialization of solution"
```
These commands can also be copy-pasted into Powershell or Powershell ISE
