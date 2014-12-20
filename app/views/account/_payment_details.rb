<form role="form" id="cardForm" action="/account" method="POST" class="form-horizontal">
<!--  <div class="form-group">
    <label class="col-sm-3 control-label">Test Card Info</label>
    <div class="col-sm-7">
      <div class="form-control-static">4242424242424242, 11/19, 123 - <a href="https://stripe.com/docs/testing">additional test cards</a></div>
    </div>
  </div> -->
  <div class="form-group">
    <label class="col-sm-3 control-label">Card Number</label>
    <div class="col-sm-4">
      <input id="card-num" type="text" class="form-control" placeholder="XXXX XXXX XXXX XXXX"  data-stripe="number" style="background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABHklEQVQ4EaVTO26DQBD1ohQWaS2lg9JybZ+AK7hNwx2oIoVf4UPQ0Lj1FdKktevIpel8AKNUkDcWMxpgSaIEaTVv3sx7uztiTdu2s/98DywOw3Dued4Who/M2aIx5lZV1aEsy0+qiwHELyi+Ytl0PQ69SxAxkWIA4RMRTdNsKE59juMcuZd6xIAFeZ6fGCdJ8kY4y7KAuTRNGd7jyEBXsdOPE3a0QGPsniOnnYMO67LgSQN9T41F2QGrQRRFCwyzoIF2qyBuKKbcOgPXdVeY9rMWgNsjf9ccYesJhk3f5dYT1HX9gR0LLQR30TnjkUEcx2uIuS4RnI+aj6sJR0AM8AaumPaM/rRehyWhXqbFAA9kh3/8/NvHxAYGAsZ/il8IalkCLBfNVAAAAABJRU5ErkJggg==); background-attachment: scroll; background-position: 100% 50%; background-repeat: no-repeat;">
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-3 control-label">Card Details</label>
    <div class="col-sm-4">
      <div class="row">
        <div class="col-xs-4">
          <input id="card-month" type="text" size="2" maxlength="2" class="form-control" placeholder="MM" data-stripe="exp-month">
        </div>
        <div class="col-xs-4">
          <input id="card-year" type="text" size="2" maxlength="2" class="form-control" placeholder="YY" data-stripe="exp-year">
        </div>
        <div class="col-xs-4">
          <input id="card-cvc" type="text" size="3" maxlength="3" class="form-control" placeholder="CVC" data-stripe="cvc">
        </div>
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-6">
      <div id="cardFormError" class="alert alert-danger hidden" role="alert">
        <p></p>
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-3 col-sm-4">
      <button type="submit" class="btn btn-primary update-card">Update Card</button>
    </div>
  </div>
</form>