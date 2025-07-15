# Stage 1: build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copy csproj dan restore dependency
COPY PortofolioMe/*.csproj ./PortofolioMe/
RUN dotnet restore ./PortofolioMe/PortofolioMe.csproj

# Copy semua file dan publish
COPY . .
WORKDIR /src/PortofolioMe
RUN dotnet publish -c Release -o /app/publish

# Stage 2: runtime
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 80
ENV ASPNETCORE_URLS=http://+:80
ENTRYPOINT ["dotnet", "PortofolioMe.dll"]
