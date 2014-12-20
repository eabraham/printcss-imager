<form role="form" id="set-plan-form" action="/account" method="PUT" class="form-horizontal">
  <div class="form-group">
    <label for="plan" class="col-sm-3 control-label">Plan</label>
    <div class="col-sm-9">
      
        <div class="radio">
          <label>
            <input type="radio" <%= @plan == 'Yearly' ? "checked" : "" %> name="plan" value="yearly" data-toggle="radio">
            <span>Billed Yearly - $49.99</span> <span class="good-news">(2 free months!!)</span>
          </label>
        </div>
      
        <div class="radio">
          <label>
            <input type="radio" <%= @plan == 'Monthly' ? "checked" : "" %> name="plan" value="monthly" data-toggle="radio">
            <span>Billed Monthly - $4.99</span>
          </label>
        </div>
      
    </div>
  </div>
  <div class="col-sm-offset-3 col-sm-9">
    <button type="submit" class="btn btn-primary">Update Plan</button>
  </div>
</form>