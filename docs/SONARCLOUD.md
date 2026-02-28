# SonarCloud Configuration

## Setup (one-time)

1. Go to https://sonarcloud.io/projects/create
2. Select GitHub → choose `tunisiano187/Chocolatey-packages1`
3. SonarCloud will create a project with key `tunisiano187_Chocolatey-packages1`
4. Generate a token: SonarCloud → My Account → Security → Generate Token
5. Add it as a GitHub secret:
   - GitHub repo → Settings → Secrets and variables → Actions
   - Add secret named: `SONAR_TOKEN`
   - Value: the token generated in step 4

## Project config

`sonar-project.properties` is already configured:
```
sonar.projectKey=tunisiano187_Chocolatey-packages1
sonar.organization=tunisiano187
sonar.sources=.
sonar.sourceEncoding=UTF-8
```

## Status

Once SONAR_TOKEN is set, SonarCloud analysis will run automatically on every PR and push to main.
