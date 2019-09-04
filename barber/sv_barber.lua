

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
ESX.RegisterServerCallback('dqp:GetCoiffeurMontant', function(source, cb, _)
	--("ss")
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
  k = xPlayer.get('money')
  if k >= 50 then
    xPlayer.removeMoney(50)
    cb(true)
  else
    cb(false)
  end
end)


ESX.RegisterServerCallback('dqp:GetTenues', function(source, cb, _)
	--("ss")
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll(
		'SELECT * FROM user_tenue WHERE identifier = @identifier',
		{
      ['@identifier'] = xPlayer.identifier
		},
    function(result)
    --print(json.encode(result))
			cb(result)
		end
	)
end)

ESX.RegisterServerCallback('dqp:GetMoneyVet', function(source, cb, _)
	--("ss")
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
  if xPlayer.get('money') >= 50 then
    xPlayer.removeMoney(50)
    cb(true)
    TriggerClientEvent("dqp:isxkaaa9921",source)
  else
    
		TriggerClientEvent('esx:showNotification', _source, 'Pas assez d\'argent')
    cb(false)
  end
end)

RegisterServerEvent('dqp:SaveTenueS')
AddEventHandler('dqp:SaveTenueS', function(label,skin)
  local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
  MySQL.Async.execute(
    'INSERT INTO user_tenue (identifier,label,tenue) VALUES(@identifier,@label,@skin)',
    {
      ['@label'] = label, 
      ['@skin'] = json.encode(skin),

    ['@identifier'] =  xPlayer.identifier
    }
  )

end)

RegisterServerEvent('dqp:DeleteTenue')
AddEventHandler('dqp:DeleteTenue', function(id,label)

  MySQL.Async.execute(
    'DELETE FROM user_tenue WHERE id = @id',
    {
      ['@id'] =  id
    }
  )
  TriggerClientEvent("esx:showNotification",source,"Tenue supprimé")

end)

RegisterServerEvent('dqp:RenameTenue')
AddEventHandler('dqp:RenameTenue', function(id,label)

  MySQL.Async.execute(
    'UPDATE user_tenue SET label = @label WHERE id=@id',
    {
      ['@id'] = id,
      ['@label'] = label

    }
  )
  TriggerClientEvent("esx:showNotification",source,"Vous avez bien renommé votre tenue en "..label)

end)