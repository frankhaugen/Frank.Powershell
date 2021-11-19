# Create solution file
dotnet new sln

# Create project folders
mkdir "$solutionname"
mkdir "$solutionname.Tests"

# Create projects
dotnet new editorconfig
dotnet new nugetconfig
dotnet new classlib -o "$solutionname" -f $dotnet --no-restore
dotnet new xunit -o "$solutionname.Tests" -f $dotnet --no-restore

# Add references between projects
dotnet add "$solutionname.Tests/$solutionname.Tests.csproj" reference "$solutionname/$solutionname.csproj"

# Add projects to solution
dotnet sln "$solutionname.sln" add "$solutionname/$solutionname.csproj"
dotnet sln "$solutionname.sln" add "$solutionname.Tests/$solutionname.Tests.csproj"

# Initial builds to see that all works as expected
dotnet restore --verbosity q --source https://api.nuget.org/v3/index.json --ignore-failed-sources
dotnet build --verbosity q --no-restore
dotnet test --verbosity q --no-restore --no-build
