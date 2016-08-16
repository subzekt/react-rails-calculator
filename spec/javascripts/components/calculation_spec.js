//= require react
//= require react_ujs
//= require components

var TestUtils = React.addons.TestUtils;
describe('Calculation Form', function () {
    var react_dom;
    var dom_node;

    beforeEach(function() {
        react_dom = TestUtils.renderIntoDocument(React.createElement(Calculation));
        dom_node = ReactDOM.findDOMNode(react_dom);
    });


    it('Form has 4 buttons namely addition subtraction multiplication division', function () {
      var renderedButtons = dom_node.querySelectorAll(".btn.btn-primary");
      expect(renderedButtons.length).toEqual(4);
      expect(renderedButtons[0].name).toEqual('addition');
      expect(renderedButtons[1].name).toEqual('subtraction');
      expect(renderedButtons[2].name).toEqual('multiplication');
      expect(renderedButtons[3].name).toEqual('division');
    });

    it('Form has 2 inputs and 1 text area', function () {
      var renderedInputs = dom_node.querySelectorAll("input");
      expect(renderedInputs.length).toEqual(2);
      var renderedInputs = dom_node.querySelectorAll("textarea");
      expect(renderedInputs.length).toEqual(1);
    });

    it('Buttons are disabled initially as the input values are nil and invalid', function () {
      var renderedButtons = dom_node.querySelectorAll(".btn.btn-primary");
      expect(renderedButtons[0].disabled).toEqual(true);
      expect(renderedButtons[1].disabled).toEqual(true);
      expect(renderedButtons[2].disabled).toEqual(true);
      expect(renderedButtons[3].disabled).toEqual(true);
    });

    it('Buttons are enabled on valid data for first number and second number', function () {
      // <input ref="input" />
      var renderedInputs = dom_node.querySelectorAll("input");
      first_number_node = renderedInputs[0];
      first_number_node.value = 1;
      TestUtils.Simulate.change(first_number_node);

      second_number_node = renderedInputs[1];
      second_number_node.value = 2;
      TestUtils.Simulate.change(second_number_node);

      var renderedButtons = dom_node.querySelectorAll(".btn.btn-primary");
      expect(renderedButtons[0].disabled).toEqual(false);
      expect(renderedButtons[1].disabled).toEqual(false);
      expect(renderedButtons[2].disabled).toEqual(false);
      expect(renderedButtons[3].disabled).toEqual(false);

    });

    it('Buttons are disabled on invalid data for first number but valid data on second number', function () {
      var renderedInputs = dom_node.querySelectorAll("input");
      // valid data for the second number
      second_number_node = renderedInputs[1];
      second_number_node.value = 2;
      TestUtils.Simulate.change(second_number_node);

      // negative value for first number
      first_number_node = renderedInputs[0];
      first_number_node.value = -1;
      TestUtils.Simulate.change(first_number_node);

      var renderedButtons = dom_node.querySelectorAll(".btn.btn-primary");
      expect(renderedButtons[0].disabled).toEqual(true);
      expect(renderedButtons[1].disabled).toEqual(true);
      expect(renderedButtons[2].disabled).toEqual(true);
      expect(renderedButtons[3].disabled).toEqual(true);

      // less than allowed  value for first number
      first_number_node.value = 0;
      TestUtils.Simulate.change(first_number_node);

      expect(renderedButtons[0].disabled).toEqual(true);
      expect(renderedButtons[1].disabled).toEqual(true);
      expect(renderedButtons[2].disabled).toEqual(true);
      expect(renderedButtons[3].disabled).toEqual(true);

      // more than allowed  value for first number
      first_number_node.value = 100;
      TestUtils.Simulate.change(first_number_node);

      expect(renderedButtons[0].disabled).toEqual(true);
      expect(renderedButtons[1].disabled).toEqual(true);
      expect(renderedButtons[2].disabled).toEqual(true);
      expect(renderedButtons[3].disabled).toEqual(true);
    });

    it('Buttons are disabled on invalid data for second number but valid data on first number', function () {
      var renderedInputs = dom_node.querySelectorAll("input");

      first_number_node = renderedInputs[0];
      first_number_node.value = 5;
      TestUtils.Simulate.change(first_number_node);

      second_number_node = renderedInputs[1];
      second_number_node.value = -2;

      TestUtils.Simulate.change(second_number_node);
      var renderedButtons = dom_node.querySelectorAll(".btn.btn-primary");
      expect(renderedButtons[0].disabled).toEqual(true);
      expect(renderedButtons[1].disabled).toEqual(true);
      expect(renderedButtons[2].disabled).toEqual(true);
      expect(renderedButtons[3].disabled).toEqual(true);

      second_number_node = renderedInputs[1];
      second_number_node.value = 0;

      TestUtils.Simulate.change(second_number_node);
      expect(renderedButtons[0].disabled).toEqual(true);
      expect(renderedButtons[1].disabled).toEqual(true);
      expect(renderedButtons[2].disabled).toEqual(true);
      expect(renderedButtons[3].disabled).toEqual(true);

      second_number_node = renderedInputs[1];
      second_number_node.value = 102;

      TestUtils.Simulate.change(second_number_node);
      expect(renderedButtons[0].disabled).toEqual(true);
      expect(renderedButtons[1].disabled).toEqual(true);
      expect(renderedButtons[2].disabled).toEqual(true);
      expect(renderedButtons[3].disabled).toEqual(true);
    });
  
});