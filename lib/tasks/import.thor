class Import < Thor
  #include Thor::Actions

  desc "users DOC", "Import users from the Humble NDA Document"

  def users(doc_key)
    require "./config/environment"
    require 'google_drive'

    google_user = ask "Google Email: "
    google_password = ask "Google Password: "

    session = GoogleDrive.login(google_user, google_password)

    ws = session.spreadsheet_by_key(doc_key).worksheets[0]

    #skip header
    for row in 2..ws.num_rows
      pass = SecureRandom.urlsafe_base64
      Date.parse
      user = {
          name: ws[row, 3],
          email: ws[row, 4],
          nda_signed_date: Date.strptime(ws[row, 9], '%m/%d/%Y'),
          password: pass,
          password_confirmation: pass
      }
      nda_date = user.delete(:nda_signed_date)
      unless User.find_by_email(user[:email])
        u = User.new user
        u.nda_signed_date = nda_date
        u.roles.build role: 'user'
        u.save!

        u.systems.create! name: 'Imported System 1',
            operating_system: ws[row, 5],
            processor: ws[row, 6],
            graphics_card: ws[row, 7],
            graphics_driver: ws[row, 8]
      end
    end
  end
end