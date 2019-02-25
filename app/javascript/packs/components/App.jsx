import React from "react";
import Chart from "./Chart";

const App = ({ code }) => {
  return (
    <div>
      <h5 className="chart-header">年初来</h5>
      <div className="col-7 per-container">
        <Chart code={code} />
      </div>
      <div className="operator-container">
        <div>PERの最大値</div>
        <select name="select-per-current" id="select-per-current" className="select-per form-control">
          { selectOptions([null, 10, 15, 20, 30, 50, 100]) }
        </select>
      </div>
      <div className="clearfix" />
      <h5 className="chart-header">全期間</h5>
      <div className="col-7 per-container">
        <canvas id="per-entire" className="per-chart" />
      </div>
      <div className="operator-container">
        <div>PERの最大値</div>
        <select name="select-per-entire" id="select-per-entire" className="select-per form-control">
          { selectOptions([null, 10, 15, 20, 30, 50, 100]) }
        </select>
      </div>
    </div>
  );
};

function selectOptions(values) {
  return values.map((v, i) => <option value={v} key={i}>{v}</option>);
}

export default App;
