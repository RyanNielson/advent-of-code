defmodule Day05 do
  def run(input) do
    input
    |> find_password(0, "")
  end

  def find_password(_id, _index, password) when byte_size(password) >= 8, do: password

  def find_password(id, index, password) do
    new_password = :crypto.hash(:md5, "#{id}#{index}")
    |> Base.encode16
    |> handle_hash(password)

    find_password(id, index + 1, new_password)
  end

  def handle_hash("00000" <> hash_remains, password), do: password <> String.at(hash_remains, 0)
  def handle_hash(_hash, password), do: password
end
