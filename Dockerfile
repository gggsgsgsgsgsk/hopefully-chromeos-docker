# Use a base image with a graphical interface and VNC support
FROM kasmweb/core:1.11.0

# Install necessary packages for audio support
RUN apt-get update && apt-get install -y \
    pulseaudio \
    alsa-utils

# Set up user and environment for KasmVNC
RUN useradd -ms /bin/bash kasm_user && \
    echo "kasm_user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER kasm_user

# Set up VNC and audio configurations
ENV DISPLAY=:1
ENV PULSE_SERVER=unix:/run/user/$(id -u)/pulse/native

# Expose necessary ports
EXPOSE 6901 5901

# Start KasmVNC server
CMD ["start-vnc-session"]
