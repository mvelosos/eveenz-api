require 'rails_helper'

RSpec.describe PasswordsMailer, type: :mailer do
  describe 'send_recovery_code' do
    let(:user) { FactoryBot.create(:user) }
    let(:mail) { PasswordsMailer.send_recovery_code(user).deliver_now }

    before do
      user.create_password_recovery!
    end

    it 'renders the subject' do
      expect(mail.subject).to eq('Instruções para recuperação de senha!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the user recovery code' do
      expect(mail.body.encoded).to match(user.password_recovery.code)
    end

    it 'renders the user username' do
      expect(mail.body.encoded).to match(user.username)
    end
  end

  describe 'password_successfully_updated' do
    let(:user) { FactoryBot.create(:user) }
    let(:mail) { PasswordsMailer.password_successfully_updated(user).deliver_now }

    before do
      user.update!(password: 'foobar123')
    end

    it 'renders the subject' do
      expect(mail.subject).to eq('Sua senha foi alterada com sucesso!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the user username' do
      expect(mail.body.encoded).to match(user.username)
    end
  end
end
