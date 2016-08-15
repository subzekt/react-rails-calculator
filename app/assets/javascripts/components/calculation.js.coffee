@Calculation = React.createClass
  getInitialState: ->
    first_number: ''
    second_number: ''
    operation_type: ''
    display: ''
    can_submit_form: true
  is_allowed_value: (number) ->
#    allow only the positive integers less than 100
#    if the number is float then it is different from the parse integer value
    parseInt( number ) == parseFloat( number ) && number > 0 && number < 100
  valid: ->
    @is_allowed_value(@state.first_number) && @is_allowed_value(@state.second_number)
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
    if !@is_allowed_value(e.target.value)
      @setState "display": "error"
    else
      @setState "display": ""
  handleClick: (e) ->
    @setState "operation_type": e.target.name
  handleSubmit: (e) ->
    e.preventDefault()
    @setState "can_submit_form": false
    $.ajax
      method: 'POST'
      url: "/calculations/calculate"
      data: @state
      dataType: 'JSON'
      success: @handleSuccess
      error: @handleError
  handleSuccess: (data) ->
    @setState "can_submit_form": true
    @setState "display": data.Result
    console.log(data.ID)
  handleError: (xhr, status, err) ->
    @setState "display": "error"
  render: ->
    React.DOM.form
      className: 'calculator-form'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'row'
        React.DOM.div
          className: 'col-sm-2'
          React.DOM.div
            className: 'form-group'
            React.DOM.input
              type: 'number'
              className: 'form-control'
              placeholder: 'First Number'
              name: 'first_number'
              value: @state.first_number
              onChange: @handleChange
        React.DOM.div
          className: 'col-sm-2'
          React.DOM.div
            className: 'form-group'
            React.DOM.input
              type: 'number'
              className: 'form-control'
              placeholder: 'Second Number'
              name: 'second_number'
              value: @state.second_number
              onChange: @handleChange

      React.DOM.div
        className: 'form-group'
        React.DOM.button
          type: 'submit'
          name: 'addition'
          value: true
          className: 'btn btn-primary'
          onClick: @handleClick
          disabled: !@valid() && !@can_submit_form
          'Add'
        React.DOM.button
          type: 'submit'
          name: 'subtraction'
          value: true
          className: 'btn btn-primary'
          onClick: @handleClick
          disabled: !@valid()  && !@can_submit_form
          'Subtract'
        React.DOM.button
          type: 'submit'
          name: 'multiplication'
          value: true
          className: 'btn btn-primary'
          onClick: @handleClick
          disabled: !@valid()  && !@can_submit_form
          'Multiply'
        React.DOM.button
          type: 'submit'
          name: 'division'
          value: true
          className: 'btn btn-primary'
          onClick: @handleClick
          disabled: !@valid()  && !@can_submit_form
          'Divide'
      React.DOM.div
        className: 'row'
        React.DOM.div
          className: 'col-sm-4'
          React.DOM.div
            className: 'form-group'
            React.DOM.input
              type: 'textarea'
              name: 'display'
              value: @state.display
              className: 'form-control'
              disabled: true