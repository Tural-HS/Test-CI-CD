# First Stage: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app
COPY . . 
RUN dotnet publish -c Release -o /out  

# Second Stage: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# DEBUG: Check if /out exists in build-env before copy
RUN echo "Contents of /out in build-env:" && ls -la /out

# Attempt to copy more explicitly to /app
COPY --from=build-env /out /app 
ENTRYPOINT ["dotnet", "Test-CI-CD.dll"] 
