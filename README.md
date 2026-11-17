# Azure DevOps Delivery Lab

A small portfolio lab for learning Azure Boards, Git, automated testing, Azure Pipelines, Terraform, and Azure deployment through a Service Status API.

## Learning notes

Start with [Learning Notes](docs/learning-notes.md) for plain-language explanations of MCP, Azure Boards work-item hierarchy, and this lab's current setup.

## Application

The ASP.NET Core API is in `src/ServiceStatus.Api`. Its `/health` endpoint returns a healthy status.

Build it with the .NET 10 SDK:

```powershell
dotnet build .\src\ServiceStatus.Api\ServiceStatus.Api.csproj
```

Automated tests are in `tests/ServiceStatus.Api.Tests`; the pipeline recipe is in `azure-pipelines.yml`. The pipeline still needs to be configured and run in Azure DevOps. Terraform infrastructure is a later lab step.
