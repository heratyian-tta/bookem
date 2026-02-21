class ImageUploader < CarrierWave::Uploader::Base
  storage :file

  # Store uploads in a deterministic, app-owned path.
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Restrict upload to common image types.
  def extension_allowlist
    %w[jpg jpeg gif png webp]
  end
end
