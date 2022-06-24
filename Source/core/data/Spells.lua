Spells = {}

function Spells.bookDataType()
    return WindowData.Spellbook.Type
end

function Spells.bookDataEvent()
    return WindowData.Spellbook.Event
end

function Spells.bookData(bookId)
    return WindowData.Spellbook[bookId]
end

function Spells.firstSpellNum(bookId)
    return Spells.bookData(bookId).firstSpellNum
end