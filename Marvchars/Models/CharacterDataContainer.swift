struct CharacterDataContainer<T: Decodable>: Decodable {
    let results: [T]
}
