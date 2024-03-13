class ProcessImportJob < ApplicationJob
  queue_as :default

  def perform(file, import_record, user_id)
    import_record.status = "processing"
    import_record.save!
    ImportsService.process_file(file, import_record, user_id)
  end
end
