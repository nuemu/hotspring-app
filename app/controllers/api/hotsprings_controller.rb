class Api::HotspringsController < Api::BaseController
  def index
    hotsprings = Hotspring.all
    render json: hotsprings
  end

  def show
    hotspring = Hotspring
                .includes(:posts, articles: :user, comments: :user)
                .find_between(params[:lat].to_f, params[:lon].to_f)
    hotspring_json = HotspringSerializer.new(hotspring, { include: [:posts, :articles, :comments] })
    render json: hotspring_json
  end

  def create
    hotspring = Hotspring.new(hotspring_params)
    hotspring.save
    render json: hotspring
  end

  def update
    hotspring = Hotspring.find_by(latitude: params[:lat], longtitude: params[:lon])
    hotspring.update(hotspring_params)
    render json: hotspring
  end

  def image
    upload_file_name = params[:title]
    upload_file_path = Rails.root.join('tmp') + upload_file_name
    File.binwrite(upload_file_path, params[:image].read)
    content_type = params[:image].content_type
    lanlon = params[:title].split(',')
    @hotspring = Hotspring.find_between(lanlon[0].to_f, lanlon[1].to_f)
    delete_image if @hotspring.image_url
    upload_image(upload_file_name, upload_file_path, content_type)
  end

  def upload_image(title, path, content_type)
    google_drive_initializer
    metadata = Google::Apis::DriveV3::File.new(name: title, parents: [ENV['GOOGLE_DRIVE_ID']])
    metadata = @drive.create_file(metadata, upload_source: path.to_s, content_type: content_type)
    metadata.name.split(',')
    url = 'https://drive.google.com/uc?export=view&id=' + metadata.id
    @hotspring.update(image_url: url)
    render json: 'success!'
  end

  def delete_image
    google_drive_initializer
    id = @hotspring.image_url.split('id=')[1]
    puts id
    @drive.delete_file(id)
  end

  private

  def hotspring_params
    params.permit(:name, :status, :latitude, :longtitude, :description)
  end
end
