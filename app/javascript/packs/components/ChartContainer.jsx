import React from "react";
import Chart from "./Chart";
import { useState } from "react";

const ChartContainer = ({ code, config, children }) => {
  const [max, setMax] = useState();

  return (
    <>
      <h5 className="chart-header">{ children }</h5>
      <div className="col-7 per-container">
        <Chart code={code} option={config} max={max} />
      </div>
      <div className="operator-container">
        <div>PERの最大値</div>
        <select onChange={(e) => { setMax(maxValue(e)) }} className="select-per form-control">
          { selectOptions([null, 10, 15, 20, 30, 50, 100]) }
        </select>
      </div>
    </>
  );
};

function selectOptions(values) {
  return values.map((v, i) => <option value={v} key={i}>{v}</option>);
}

function maxValue(e) {
  const val = e.currentTarget.selectedOptions[0].value;
  return val ? parseInt(val) : null;
}

export default ChartContainer;
