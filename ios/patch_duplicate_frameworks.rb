#!/usr/bin/env ruby

require 'xcodeproj'
require 'pathname'

# Path to the .xcodeproj file
project_path = 'Runner.xcodeproj'

# Open the project
project = Xcodeproj::Project.open(project_path)

# Get the main target
target = project.targets.find { |t| t.name == 'Runner' }

# Find the build phases that handle frameworks
target.build_phases.each do |phase|
  next unless phase.is_a?(Xcodeproj::Project::Object::PBXFrameworksBuildPhase)
  
  # Create sets to detect duplicates
  framework_paths = Set.new
  duplicate_frameworks = []
  
  # Find duplicates
  phase.files.each do |build_file|
    file_ref = build_file.file_ref
    next unless file_ref
    path = file_ref.path
    next unless path && path.end_with?('.framework')
    
    # Simple name without path
    name = File.basename(path)
    
    if framework_paths.include?(name)
      duplicate_frameworks << build_file
    else
      framework_paths.add(name)
    end
  end
  
  # Remove duplicates
  duplicate_frameworks.each do |build_file|
    phase.remove_build_file(build_file)
  end
end

# Save changes
project.save 