StringApi = wstring

function StringApi.fromTid(tid)
   return GetStringFromTid(tid)
end

function StringApi.toWString(string)
   return StringToWString(string)
end

function StringApi.fromWString(wString)
   return WStringToString(wString)
end