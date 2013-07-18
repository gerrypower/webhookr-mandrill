class MandrillHooks

  # All 'on_' handlers are optional. Omit any you do not require.
  # Details on the payload structure: http://help.mandrill.com/entries/24466132-Webhook-Format

  def on_send(incoming)
    payload = incoming.payload
    puts("send: #{payload.msg.email}")
  end

  def on_hard_bounce(incoming)
    payload = incoming.payload
  end

  def on_soft_bounce(incoming)
    payload = incoming.payload
  end

  def on_open(incoming)
    payload = incoming.payload
  end

  def on_click(incoming)
    payload = incoming.payload
  end

  def on_spam(incoming)
    payload = incoming.payload
  end

  def on_unsub(incoming)
    payload = incoming.payload
  end

  def on_reject(incoming)
    payload = incoming.payload
  end

end