class ChildInfo < ApplicationRecord
  # ----дочерние записи--------

  # Заполнители причин отсутствия
  has_many :null_flavors, class_name: "NullFlavor", primary_key: "guid", foreign_key: "parent_guid", dependent: :destroy
  accepts_nested_attributes_for :null_flavors, allow_destroy: true
  # инфо по матери ребенка до месяца
  has_one :related_subject, class_name: "RelatedSubject", primary_key: "certificate_id", foreign_key: "certificate_id", dependent: :destroy
  accepts_nested_attributes_for :related_subject, allow_destroy: true

  def to_s
    "Ребенок до года [#{:certificate_id}] вес: #{weight}(г.) #{which_account}- по счету"
  end

  # For using in UniversalEnttityController or other models
  # Для использования в универсальном контроллере сущностей
  # и в других моделях
  def self.permitted_params
    [:id, :guid, :term_pregnancy, :weight, :which_account, :_destroy,
     related_subject_attributes: RelatedSubject.permitted_params,
     null_flavors_attributes: NullFlavor.permitted_params]
  end
end
