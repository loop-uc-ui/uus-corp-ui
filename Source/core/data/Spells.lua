Spells = {}

Spells.Books = {
    Magery = 3834,
    Necro = 8787
}

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

function Spells.isNecro(bookId)
    return Spells.bookData(bookId).objType == Spells.Books.Necro
end

function Spells.isMagery(bookId)
    return Spells.bookData(bookId).objType == Spells.Books.Magery
end