FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source

COPY *.sln .
COPY MvcMovie/*.csproj ./MvcMovie/
RUN dotnet restore

COPY MvcMovie/. ./MvcMovie/
WORKDIR /source/MvcMovie
RUN dotnet publish -c release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "MvcMovie.dll"]

