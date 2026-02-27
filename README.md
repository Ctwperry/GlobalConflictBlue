# GlobalConflictBlue
This is not my original project. I am looking to revitalize this project for future purposes to provide training and also a fun
environment for maritime warfare simulations
For the Installer please use the following link. Once I figure this our more ill add a better way to get this. 
https://drive.google.com/file/d/1XLp-akiw_9BTBr3HBLf0Gtk_mmbHslpa/view?usp=share_link

## Improvement roadmap

To make the project easier to run, maintain, and expand, prioritize the following:

1. **Improve onboarding and setup docs**
   - Document supported OS versions.
   - Explain required runtime dependencies.
   - Provide a reproducible install path that does not rely on a single external installer link.

2. **Add script-level quality checks**
   - Add a lightweight script to syntax-check all Python scripts.
   - Run this check in CI to catch breakages before release.

3. **Modernize and modularize AI scripts**
   - Reduce wildcard imports where practical.
   - Extract common behavior into shared helpers with clear interfaces.
   - Add comments and naming cleanups in frequently modified scripts.

4. **Create scenario/database validation tooling**
   - Add static validation for mission templates and database fields.
   - Flag missing assets and malformed records before runtime.

5. **Build a contributor workflow**
   - Add contribution guidelines, coding conventions, and test/check expectations.
   - Define release notes and versioning practices for updates.
