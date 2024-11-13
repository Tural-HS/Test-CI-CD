FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env

WORKDIR /app
COPY . . 
RUN dotnet publish -c Release -o /out  # Corrected the publish command
RUN ls /out  # Check if /out contains the published files

# Second Stage: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /out .  # Copy build output from /out in the build-env stage
ENTRYPOINT ["dotnet", "demo-net.dll"]
