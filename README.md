# Vehicle Troubleshooter 🚗

## Overview

**Vehicle Troubleshooter** is a Prolog-based diagnostic tool designed to help identify and troubleshoot common vehicle problems. By analyzing symptoms related to vehicle issues, the system attempts to pinpoint the most likely problems and their underlying causes. This project simplifies the process of diagnosing complex car issues through an interactive user interface where the user provides responses to vehicle symptoms.

## Features

- **Symptom-based diagnosis**: The program associates common vehicle problems with symptoms to suggest potential issues.
- **Prioritized problem identification**: Problems are ranked based on severity, providing a more efficient troubleshooting process.
- **Cause identification**: After diagnosing the issue, the system presents potential causes for each identified problem.
- **Interactive problem-solving**: Users are asked about specific symptoms to narrow down the possible issues, making it easier to diagnose complex problems.

## How it works

1. The user is prompted to provide input on symptoms they are experiencing.
2. Based on the symptoms, the system attempts to diagnose potential issues and prioritize them.
3. If the problem is determined, the tool suggests the most probable cause.
4. If multiple problems are possible, the system continues to ask about additional symptoms to further refine the diagnosis.

## Example Problems

- **Engine not starting**: Includes symptoms such as clicking noise or the car not starting at all.
- **Electrical system failures**: Issues with lights, fuses, or the battery.
- **Alternator failure**: Symptoms include a dead battery or dimming lights.
- **Malfunctioning automatic transmission control module**: Includes issues like being stuck in one gear or a transmission warning light.

## Getting Started

1. Install a Prolog interpreter (such as SWI-Prolog).
2. Load the program into the Prolog environment.
3. Start the diagnostic process by running the `start.` command.

## Future Enhancements

- Expansion of the problem set to include more vehicle issues.
- Enhanced symptom categorization for better problem isolation.
- Improved user interaction, including more detailed symptom questions.
