#!/usr/bin/env bash

export ARM_SUBSCRIPTION_ID="00000000-0000-0000-0000-000000000000"
export ARM_TENANT_ID="00000000-0000-0000-0000-000000000000"
export ARM_CLIENT_ID="00000000-0000-0000-0000-000000000000"
export ARM_CLIENT_SECRET="00000000-0000-0000-0000-000000000000"

# ARM_SUBSCRIPTION_ID is get from "az account list" field *id* on the wanted account.
# ARM_TENANT_ID is get from "az account list" field *tenantId* on the wanted account.
# ARM_CLIENT_ID is get from Azure Portal -> Microsoft Entra ID -> App registrations -> *App name* -> Overview -> Application (client) ID
# ARM_CLIENT_SECRET is get from Azure Portal -> Microsoft Entra ID -> App registrations -> App name -> Certificates & secrets -> *Secret Name* -> Value
