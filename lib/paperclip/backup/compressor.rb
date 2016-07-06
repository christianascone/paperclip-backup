module Paperclip
  module Backup

    class Compressor

      def self.get_attachment(resource, attachment, backup_dir)
        FileUtils.mkdir_p backup_dir
        filename = "#{backup_dir}/#{resource.id}#{File.extname(resource.send("#{attachment}_file_name"))}"

        # Try 3 times to download
        3.times do
          begin
            File.open(filename, 'wb') do |file|
              transfer = resource.send(attachment).s3_object(:original).read do |chunk|
                file.write(chunk)
              end

              # Check if file is downloaded correctly
              s3_md5 = transfer[:etag].gsub('"', '')
              downloaded_md5 = Digest::MD5.hexdigest(File.read(filename))

              return filename  if s3_md5 == downloaded_md5
            end
          rescue
          end
        end

        raise 'Cannot download original attachment'
      end


      def self.compress zipfile_name, source_dir
        Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
          Dir["#{source_dir}/*"].each do |filename|
            zipfile.add(File.basename(filename), filename)
          end
        end
      end


      def self.upload_to_glacier zipfile_name

      end
    end
  end
end