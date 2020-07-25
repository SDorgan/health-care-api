class BaseRepository
  def initialize(table_name)
    @table_name = table_name
  end

  def all
    load_collection(dataset)
  end

  def find(id)
    load_object(dataset.first!(pk_column => id))
  end

  def destroy(a_record)
    find_dataset_by_id(a_record.id).delete.positive?
  end

  alias delete destroy

  def delete_all
    dataset.delete
  end

  private

  def dataset
    DB[@table_name]
  end

  def insert(a_record)
    dataset.insert(changeset(a_record))
  end

  def load_collection(rows)
    rows.map { |a_record| load_object(a_record) }
  end

  def pk_column
    Sequel[@table_name][:id]
  end
end
