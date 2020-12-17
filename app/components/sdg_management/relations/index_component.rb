class SDGManagement::Relations::IndexComponent < ApplicationComponent
  include Header

  attr_reader :records

  def initialize(records)
    @records = records
  end

  private

    def title
      t("sdg_management.menu.#{model_class.table_name}")
    end

    def model_class
      records.model
    end

    def targets_for(record)
      record.sdg_target_list
    end

    def goals_for(record)
      record.sdg_goals.map(&:code).join(", ")
    end

    def edit_path_for(record)
      {
        controller: "sdg_management/relations",
        action: :edit,
        relatable_type: record.class.name.tableize,
        id: record
      }
    end

    def search_label
      t("#{search_namespace}.label.#{model_class.table_name}")
    end

    def goal_label
      t("#{search_namespace}.advanced_filters.sdg_goals.label")
    end

    def goal_blank_option
      t("#{search_namespace}.advanced_filters.sdg_goals.all")
    end

    def goal_options
      options_from_collection_for_select(SDG::Goal.all, :code, :code_and_title, params[:goal_code])
    end

    def search_namespace
      "admin.shared.search"
    end
end
