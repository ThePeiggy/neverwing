class Everwing
  PLAY_PATH = '/purchase/listing'.freeze

  def play(score: 1994, experience: 1994)
    url = "#{base_url}#{PLAY_PATH}?global=#{global_key}&coin=#{score}&xpPlayer=#{experience}&#{left_sidekick_params}#{right_sidekick_params}k=#{user_key}&l=#{play_key}"
    response = RestClient.get(url)
  end

  def train_sidekicks
    trainable_sidekicks.each_slice(2).with_index do |pair, i|
      puts "Training dragon pair #{i+1} of #{(trainable_sidekicks.count / 2.0).ceil}"
      equip_left_sidekick(pair.first)
      equip_right_sidekick(pair.last)
      play
    end
  end

  def buy_rare_dragon
    RestClient.get("https://stormcloud-146919.appspot.com/purchase/listing/?k=ahNzfnN0b3JtY2xvdWQtMTQ2OTE5ciwLEgNVSUQiEDEyNTY4NzU5NjQzODI0NDcMCxIGUGxheWVyGICAgICAgIAKDA&l=ahNzfnN0b3JtY2xvdWQtMTQ2OTE5chQLEgdMaXN0aW5nGICAgIDgsIUJDA&")
    RestClient.get("https://stormcloud-146919.appspot.com/purchase/listing/?k=ahNzfnN0b3JtY2xvdWQtMTQ2OTE5ciwLEgNVSUQiEDEyNTY4NzU5NjQzODI0NDcMCxIGUGxheWVyGICAgICAgIAKDA&l=ahNzfnN0b3JtY2xvdWQtMTQ2OTE5chQLEgdMaXN0aW5nGICAgID0jIMKDA&")
  end

  def equip_left_sidekick(sidekick)
    return swap_left_sidekick(sidekick) if left_sidekick

    command_key = 'ahNzfnN0b3JtY2xvdWQtMTQ2OTE5chQLEgdMaXN0aW5nGICAgIC04okLDA'
    url = "#{base_url}#{PLAY_PATH}?sidekick1=#{sidekick['key']}&k=#{user_key}&l=#{command_key}"

    response = RestClient.get(url)
    @left_sidekick = sidekick if JSON.parse(response.body)['error'].nil?
  end

  def equip_right_sidekick(sidekick)
    return swap_right_sidekick(sidekick) if right_sidekick

    command_key = 'ahNzfnN0b3JtY2xvdWQtMTQ2OTE5chQLEgdMaXN0aW5nGICAgIC0qYULDA'
    url = "#{base_url}#{PLAY_PATH}?sidekick1=#{sidekick['key']}&k=#{user_key}&l=#{command_key}"

    response = RestClient.get(url)
    @right_sidekick = sidekick if JSON.parse(response.body)['error'].nil?
  end

  def swap_left_sidekick(sidekick)
    return if sidekick == left_sidekick

    command_key = 'ahNzfnN0b3JtY2xvdWQtMTQ2OTE5chQLEgdMaXN0aW5nGICAgIDG_YwJDA'
    url = "#{base_url}#{PLAY_PATH}?sidekick1=#{sidekick['key']}&sidekick2=#{left_sidekick['key']}&k=#{user_key}&l=#{command_key}"

    response = RestClient.get(url)
    @left_sidekick = sidekick if JSON.parse(response.body)['error'].nil?
  end

  def swap_right_sidekick(sidekick)
    return if sidekick == right_sidekick

    command_key = 'ahNzfnN0b3JtY2xvdWQtMTQ2OTE5chQLEgdMaXN0aW5nGICAgIC-2JwKDA'
    url = "#{base_url}#{PLAY_PATH}?sidekick1=#{sidekick['key']}&sidekick2=#{right_sidekick['key']}&k=#{user_key}&l=#{command_key}"

    response = RestClient.get(url)
    @right_sidekick = sidekick if JSON.parse(response.body)['error'].nil?
  end

  private

  def left_sidekick_params
    if left_sidekick
      "sidekick1=#{left_sidekick['key']}&xpSidekick1=99999&"
    else
      ""
    end
  end

  def right_sidekick_params
    if right_sidekick
      "sidekick2=#{right_sidekick['key']}&xpSidekick2=99999&"
    else
      ""
    end
  end
end
