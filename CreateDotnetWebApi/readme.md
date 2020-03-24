# Create a .net core WebApi -solution
This solution is created with basic projects for a clean architecture

Recomended to execute this in Powershell ISE

```
# Name of solution, (Customarily named Domain.ProductName)
$solutionname = "Company.Application"

# Path to where you keep your git -repos or solutions/projects
$repospath = "c:\repos"

# Check if repos path exists and create it if not, and move "execution context" to said path
$repospathexist = Test-Path $repospath
if(!$repospathexist)
{
    mkdir $repospath
}
cd $repospath

# Create basic solution with git
mkdir $solutionname
cd $solutionname
dotnet new sln
dotnet new gitignore  
echo "# Readme" > readme.md
git init

# Create project folders
mkdir "$solutionname"
mkdir "$solutionname.Api"
mkdir "$solutionname.Models"
mkdir "$solutionname.Tests"

# Create projects
dotnet new classlib -o "$solutionname"
dotnet new webapi -o "$solutionname.Api"
dotnet new classlib -o "$solutionname.Models"
dotnet new xunit -o "$solutionname.Tests"

# Add references between projects
dotnet add "$solutionname/$solutionname.csproj" reference "$solutionname.Models/$solutionname.Models.csproj"
dotnet add "$solutionname.Api/$solutionname.Api.csproj" reference "$solutionname/$solutionname.csproj"
dotnet add "$solutionname.Tests/$solutionname.Tests.csproj" reference "$solutionname.Api/$solutionname.Api.csproj"

# Add projects to solution
dotnet sln "$solutionname.sln" add "$solutionname/$solutionname.csproj"
dotnet sln "$solutionname.sln" add "$solutionname.Api/$solutionname.Api.csproj"
dotnet sln "$solutionname.sln" add "$solutionname.Models/$solutionname.Models.csproj"
dotnet sln "$solutionname.sln" add "$solutionname.Tests/$solutionname.Tests.csproj"

# Initial builds to see that all works as expected
dotnet restore
dotnet build
dotnet test

# Commit solution to git
git add *
git commit -m "Initialization of solution"
```
