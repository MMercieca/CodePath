ActiveAdmin.register User do
  permit_params :email, :password, :group_id

  index do
    selectable_column
    id_column
    column :email
    column :group do |o|
      case o.group_id
        when 1 then 'User'
        when 2 then 'Teacher'
        when 3 then 'Admin'
      end
    end
    column :created_at
    actions
  end  
  
  show do
    attributes_table do
      row :email
      row :created_at
      row :updated_at
      row :group do |o|
        case o.group_id
          when 1 then 'User'
          when 2 then 'Teacher'
          when 3 then 'Admin'
        end
      end
    end
  end


  filter :email
  filter :group_id, as: :select, collection: Group.all.map { |g| [g.name, g.id] }, include_blank: true
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :group_id, as: :select, collection: Group.all.map { |g| [g.name, g.id] }, include_blank: false

    end
    f.actions
  end

end
