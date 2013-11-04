class Tips::ManualImagesController < Tips::ApplicationController
  set_resource_class Tips::ManualImage

  def tips_manual_image_params
    params.require(:tips_manual_image).permit(:image)
  end

end
