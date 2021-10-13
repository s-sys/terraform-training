#!/bin/bash

# Export variables
export SPOTIFY_CLIENT_ID="SECRET_HERE"
export SPOTIFY_CLIENT_SECRET="SECRET_HERE"
export SPOTIFY_PROXY_API_KEY="crpjnn5KWgKx-H5nQOW2jrO5obpo-rL1kUyr0vkhANG0FQ9MfaWrL8l7qM-Dwa63"
export SPOTIFY_CLIENT_REDIRECT_URI=http://localhost:27228/spotify_callback

# Install spotify auth proxy application
go install github.com/conradludgate/terraform-provider-spotify/spotify_auth_proxy@latest

# Run service for authentication
~/go/bin/spotify_auth_proxy
