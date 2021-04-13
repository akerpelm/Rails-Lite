require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params, :already_built_response

  # Setup the controller
  def initialize(req, res)
    @res = res
    @req = req
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    !!res
  end

  # Set the response status code and header
  def redirect_to(url)
    raise "Cannot redirect twice" unless @already_built_response.nil?
    res.location = url
    res.status = 302
    @already_built_response ||= self.res


  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise "Cannot render twice" unless @already_built_response.nil?
      if
        res.write(content)
        res.content_type = content_type
        @already_built_response ||= self.res
      end

  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
  end

  # method exposing a `Session` object
  def session
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
  end
end

