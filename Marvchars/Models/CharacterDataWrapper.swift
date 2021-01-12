struct CharacterDataWrapper<T: Decodable>: Decodable {
    let data: CharacterDataContainer<T>
}
