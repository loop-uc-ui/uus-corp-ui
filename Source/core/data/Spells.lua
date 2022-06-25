Spells = {}

Spells.Books = {
    Magery = 3834,
    Necro = 8787,
    Ninja = 9120,
    Spellweaving = 11600,
    Chivalry = 8786,
    Bushido = 9100,
    Mysticism = 11677
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

function Spells.isNinjitsu(bookId)
    return Spells.bookData(bookId).objType == Spells.Books.Ninja
end

function Spells.isSpellweaving(bookId)
    return Spells.bookData(bookId).objType == Spells.Books.Spellweaving
end

function Spells.isChivalry(bookId)
    return Spells.bookData(bookId).objType == Spells.Books.Chivalry
end

function Spells.isBushido(bookId)
    return Spells.bookData(bookId).objType == Spells.Books.Bushido
end

function Spells.isMysticism(bookId)
    return Spells.bookData(bookId).objType == Spells.Books.Mysticism
end