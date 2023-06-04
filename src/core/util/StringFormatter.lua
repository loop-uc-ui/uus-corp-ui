StringFormatter = {}

function StringFormatter.toTwoDecimalPlaces(string)
    if type(string) == "string" then
        string = StringFormatter.toWString(string)
    end
    return StringApi.format(L"%2.2f", string)
end

function StringFormatter.fromTid(tid)
    return StringApi.fromTid(tid) --returns wstring
end

function StringFormatter:replaceChar(text, pattern, replace)
    if type(text) == "number" then
        text = self.fromTid(text)
    elseif type(text) == "string" then
        text = self.toWString(text)
    end

    if type(pattern) ~= "wstring" then
        pattern = self.toWString(pattern)
    end

    if type(replace) ~= "wstring" then
        replace = self.toWString(replace)
    end

    return wstring.gsub(
            text,
            pattern,
            replace
    )
end

function StringFormatter.toUpper(text)
    if type(text) == "string" then
        return string.upper(text)
    elseif type(text) == "wstring" then
        return StringApi.upper(text)
    end
end

function StringFormatter.toLower(text)
    if type(text) == "string" then
        return string.lower(text)
    elseif type(text) == "wstring" then
        return StringApi.lower(text)
    end
end

function StringFormatter.toWString(text)
    if type(text) == "wstring" then
        return text
    elseif type(text) == "string" then
        return StringApi.toWString(text)
    else
        return StringApi.toWString(tostring(text))
    end
end

function StringFormatter.fromWString(text)
    if type(text) == "string" then
        return text
    else
        return StringApi.fromWString(text)
    end
end

function StringFormatter.replaceTokens(token, array)
    ReplaceTokens(token, array)
end