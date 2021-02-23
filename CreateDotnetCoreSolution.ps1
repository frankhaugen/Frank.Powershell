# Name of solution, (Customarily named Domain.ProductName)
$solutionname = "Semine.IntegrationEngine"
$executionprojectname = "Api"
$executionprojecttype = "webapi"
# Path to where you keep your git -repos or solutions/projects
$repospath = "c:\repos"

# Check if repos path exists and create it if not, and move "execution context" to said path
$repospathexist = Test-Path $repospath
if (!$repospathexist) {
    mkdir $repospath
}
Set-Location $repospath

# If soltuin exist, exit, else create directory for solution
$solutionexist = Test-Path $solutionname
if (!$solutionexist) {
    mkdir $solutionname
}

# Create basic solution with git
Set-Location $solutionname
dotnet new sln
dotnet new gitignore
Write-Output "# Readme" > readme.md
git init

# Create project folders
mkdir "$solutionname"
mkdir "$solutionname.$executionprojectname"
mkdir "$solutionname.Models"
mkdir "$solutionname.Tests"

# Create projects
dotnet new classlib -o "$solutionname" -f net5.0 --langVersion 9.0 --no-restore
dotnet new $executionprojecttype -o "$solutionname.$executionprojectname" -f net5.0 --no-restore
dotnet new classlib -o "$solutionname.Models" -f net5.0 --langVersion 9.0 --no-restore
dotnet new xunit -o "$solutionname.Tests" -f net5.0 --no-restore

# Add references between projects
dotnet add "$solutionname/$solutionname.csproj" reference "$solutionname.Models/$solutionname.Models.csproj"
dotnet add "$solutionname.$executionprojectname/$solutionname.$executionprojectname.csproj" reference "$solutionname/$solutionname.csproj"
dotnet add "$solutionname.Tests/$solutionname.Tests.csproj" reference "$solutionname.$executionprojectname/$solutionname.$executionprojectname.csproj"

# Add projects to solution
dotnet sln "$solutionname.sln" add "$solutionname/$solutionname.csproj"
dotnet sln "$solutionname.sln" add "$solutionname.$executionprojectname/$solutionname.$executionprojectname.csproj"
dotnet sln "$solutionname.sln" add "$solutionname.Models/$solutionname.Models.csproj"
dotnet sln "$solutionname.sln" add "$solutionname.Tests/$solutionname.Tests.csproj"

# Add some default Nugets that often is used
dotnet add "$solutionname.Tests/$solutionname.Tests.csproj" package FluentAssertions.AspNetCore.Mvc --source https://api.nuget.org/v3/index.json -n
dotnet add "$solutionname.Tests/$solutionname.Tests.csproj" package AutoBogus --source https://api.nuget.org/v3/index.json -n
dotnet add "$solutionname.Tests/$solutionname.Tests.csproj" package NSubstitute --source https://api.nuget.org/v3/index.json -n
dotnet add "$solutionname.Tests/$solutionname.Tests.csproj" package AutoFixture --source https://api.nuget.org/v3/index.json -n
dotnet add "$solutionname.Tests/$solutionname.Tests.csproj" package xunit.abstractions --source https://api.nuget.org/v3/index.json -n
dotnet add "$solutionname.Tests/$solutionname.Tests.csproj" package Microsoft.AspNetCore.TestHost --source https://api.nuget.org/v3/index.json -n
dotnet add "$solutionname.Tests/$solutionname.Tests.csproj" package Microsoft.AspNetCore.Mvc.Testing --source https://api.nuget.org/v3/index.json -n

# Initial builds to see that all works as expected
dotnet restore --verbosity q --source https://api.nuget.org/v3/index.json --ignore-failed-sources
dotnet build --verbosity q --no-restore
dotnet test --verbosity q --no-restore --no-build

# Commit solution to git
git add *
git commit -m "Initialization of solution"

cd..